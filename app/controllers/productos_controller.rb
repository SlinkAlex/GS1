require "uri"
require "json"
require "net/http"

# encoding: UTF-8
class ProductosController < ApplicationController
  before_filter :require_authentication
  before_action :set_product, only: [:new, :show, :edit, :update, :destroy]
  before_action :set_countries, only: [:new, :edit, :update]

  # GET /productos
  # GET /productos.json
  def index

    @empresa = Empresa.find_by_prefijo(params[:empresa_id]) if params[:empresa_id]

    respond_to do |format|
      format.html { 
                    cookies.clear if params[:eliminar_cookie]

                    if params[:eliminar]  
                      @navegabilidad = "#{@empresa.prefijo} > " + @empresa.nombre_empresa + " > Productos > Eliminar Productos"
                      render :template =>'/productos/eliminar_productos.html.haml'

                    elsif params[:transferencia]
                      
                      @navegabilidad = "Productos > Transferencia"
                      render :template =>'/productos/transferir_productos.html.haml'

                    elsif params[:empresa_id].nil?

                      @navegavilidad = 'Listado General GTIN8'
                      render :template => '/productos/productos_gtin_8.html.haml'

                    else

                      @navegabilidad = "#{@empresa.prefijo} > " +  @empresa.nombre_empresa + " > Productos > Listado"
                      # para mostrar el estatus de los productos como retirados si la empresa esta retirada

                      # Las empresas retirada no pueden generar GTIN14 ni editar productos
                      if params[:empresa_retirada]
                        @ruta = "/empresas/#{params[:empresa_id]}/productos.json?empresa_retirada=true"
                      elsif params[:insolvente]
                        @ruta = "/empresas/#{params[:empresa_id]}/productos.json?insolvente=true"
                      else

                        @ruta = "/empresas/#{params[:empresa_id]}/productos.json" 
                      end

                      if params[:job] ## Muestar el loader gib mientras se esta ejecutando el DelayJOb
                          @delayed_job = true
                      end

                      render :template =>'/productos/index.html.haml'
                    end
                  }
                  
      format.json { 

                    
                    if params[:gtin]
                      gtin = params[:gtin]
                      digito_verificacion = Producto.calcular_digito_verificacion(params[:gtin].to_i,"GTIN-13")
                      codigo_generado =  gtin + digito_verificacion.to_s
                      producto = ProductosEmpresa.find(:first, :conditions => ["prefijo = ? and gtin = ?", params[:prefijo], codigo_generado])
                      render json: producto
                    elsif params[:eliminar]
                      render json: (EliminarProductosDatatable.new(view_context))
                    
                    elsif params[:gtin_8]
                      
                      render json: ProductosGtin8Datatable.new(view_context)
                    
                    elsif params[:transferir]
                      
                      render json: ProductosTransferirDatatable.new(view_context)
                   
                    
                    else

                      
                      if UsuariosAlcance.verificar_alcance(session[:perfil], session[:gerencia], 'Registrar Producto')

                        render json: ProductosDatatable.new(view_context, session[:perfil], session[:gerencia]) 
                      else
                        render json: ProductosNotEditableDatatable.new(view_context) 
                      end
                    end


                   
                  }
      format.pdf  {
                    pdf = ProductosPdf.new(@empresa, params[:tipo_gtin], params[:gtin], params[:descripcion], params[:marca], params[:codigo_producto], params[:fecha_creacion], params[:fecha_modificacion])

                    send_data pdf.render, filename: "#{@empresa.nombre_empresa.strip}_productos.pdf", type: "application/pdf", disposition: "inline"
      }
      format.xlsx{
                  if params[:exportar_gtin_8] == 'true'
                    render '/productos/productos_gtin_8.xlsx.axlsx'
                  else                    
                    render '/productos/index.xlsx.axlsx'
                  end
      }
      
    end
  end

  # GET /productos/1
  # GET /productos/1.json
  def show
    @producto = Producto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @producto }
    end
  end

  # GET /productos/new
  # GET /productos/new.json
  def new
    
    @empresa =  Empresa.find(:first, :conditions => ["prefijo = ?", params[:empresa_id]] )
    @productos_gtin_13 = Producto.find(:all, :conditions => ["tipo_gtin.tipo = ? and prefijo = ?", "GTIN-13", params[:empresa_id]], :include => [:tipo_gtin]) if params[:empresa_id].size == 5
    
    if params[:empresa_id].size == 5
      
      @excede_gtin13 = true if (@productos_gtin_13.size >= 10) 
      
    end
    
    @producto = @empresa.producto.build  # Se crea el form_for
    
    
    @gtin = params[:gtin] if params[:gtin] != ''# SI esta gtin  es para crear gtin tipo 14 base 8 o gtin 14 base 13    
    
    @producto_ = Producto.find(:first, :conditions => ["gtin like ?", params[:gtin]]) if params[:gtin]
    
    if params[:classification_id]
      @producto.classification_id = params[:classification_id]
      @producto.country_ids =  @producto_.country_ids
      @unidades = params[:unidades]
      @medida = params[:medida]
    end

    
    @base = TipoGtin.find(:first, :conditions =>["tipo like ? and base like ?", "GTIN-14", @producto_.tipo_gtin.tipo]) if @producto_
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @producto }
    end
  end

  # GET /productos/1/edit
  def edit
    @empresa = Empresa.find(:first, :conditions => ["prefijo = ?", params[:empresa_id]])
    @producto = Producto.find(:first, :conditions => ["gtin like ?", params[:id]])
    

  end

  # POST /productos
  # POST /productos.json
  def create
    @empresa = Empresa.find(:first, :conditions => ["prefijo = ?", params[:empresa_id]])
    @gtin = params[:gtin]  if params[:gtin] != ''

    params[:producto][:gtin] = Producto.crear_gtin(params[:producto][:id_tipo_gtin], params[:empresa_id], params[:gtin], params[:producto][:codigo_prod])
    params[:producto][:fecha_creacion] = Time.parse(params[:producto][:fecha_creacion]) if !params[:producto][:fecha_creacion].empty?
    params[:producto][:id_estatus] = 3
    
    # Se asigna el codigo de producto

    params[:producto][:codigo_prod] = params[:producto][:gtin][7..11] if params[:producto][:id_tipo_gtin] == '3' and (@empresa.prefijo.to_s.size == 7  or @empresa.prefijo.to_s.size == 5)
    params[:producto][:codigo_prod] = params[:producto][:gtin][9..11] if params[:producto][:id_tipo_gtin] == '3' and @empresa.prefijo.to_s.size == 9 and @empresa.prefijo.to_s[3..5] == "400"
    params[:producto][:codigo_prod] = params[:producto][:gtin][3..6] if params[:producto][:id_tipo_gtin] == '1'
    params[:producto][:codigo_prod] = params[:producto][:gtin][9..12] if params[:producto][:id_tipo_gtin] == '4' 
    params[:producto][:codigo_prod] = params[:producto][:gtin][8..12] if params[:producto][:id_tipo_gtin] == '5'  # GTIN 14 base 12 
    params[:producto][:codigo_prod] = params[:producto][:gtin][8..12] if params[:producto][:id_tipo_gtin] == '6' and (@empresa.prefijo.to_s.size == 7  or @empresa.prefijo.to_s.size == 5)
    params[:producto][:codigo_prod] = params[:producto][:gtin][10..12] if params[:producto][:id_tipo_gtin] == '6' and @empresa.prefijo.to_s.size == 9 and @empresa.prefijo.to_s[3..5] == "400"
    params[:producto][:prefijo] = params[:empresa_id]

    @producto = Producto.new(params[:producto])
    puts "PRODUCTO A ALMACENAR "+@producto.inspect
    @producto.countries = params[:countries]
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    puts params[:countries]
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    @producto.origen = 0
    
    respond_to do |format|
      if @producto.valid?
        if @producto.save
          #CREACION DE RELACION PARA UNIDADES DE MEDIDA
          if params[:quantity].present?
            cantidad = Quantity.new(units: params[:quantity][:units], producto_id: @producto, medida_id: params[:quantity][:medida_id])
            if cantidad.valid?
              cantidad.save
                if @producto.tipo_gtin.tipo != "GTIN-14"
                  data = registrar_gtin(@producto)
                end
            else
              puts "REQUEST FAILED TO API"
                format.html { 
                  render action: "new" }
            end
          end
          Auditoria.registrar_evento(session[:usuario],"producto", "Crear", Time.now, "GTIN:#{@producto.gtin} DESCRIPCION:#{@producto.descripcion} TIPO GTIN:#{@producto.tipo_gtin.tipo}")
          format.html { redirect_to empresa_productos_path, notice: "EL #{@producto.tipo_gtin.tipo} #{@producto.gtin} fue creado correctamente." }
        else
          format.html { 
            render action: "new" }
        end
      else
        format.html { 
          render action: "new" }        
      end
    end
  end

  # PUT /productos/1
  # PUT /productos/1.json
  def update
    @producto = Producto.find(:first, :conditions => ["gtin like ?", params[:id]])
    @producto.countries = params[:countries]
    puts "YYYYYYYYYYYYYYYYYYYYYYYYYYYYY"
    puts params[:countries]
    params[:producto][:fecha_creacion] = params[:producto][:fecha_creacion].to_datetime
    @producto.fecha_ultima_modificacion = Time.now
    if params[:quantity].present?
      @producto.quantity.units = params[:quantity][:units]
      @producto.quantity.medida_id = params[:quantity][:medida_id]
    end
    
    respond_to do |format|
      if @producto.update_attributes(params[:producto])
        format.html { redirect_to empresa_productos_path, notice: "GTIN #{@producto.gtin} ACTUALIZADO." }
      else
        format.html { render action: "edit" }
      end
    end
  end


  def update_multiple

    if params[:transferir] # Esta opcion se utiliza para transferir gtin de una a empresa a otra. es uin campo iculto dentro del formulario transferir_gtin8  en productos

      Producto.transferir_gtin(params[:transferir_gtin8], params[:empresa_transferir_gtin])
    
    elsif params[:eliminar]
     
      productos = Producto.eliminar(params)
      string_gtin = ""

    end

    respond_to do |format|

      format.html { redirect_to "/productos?transferencia=true", notice: "EL(LOS) GTIN FUERON TRANSFERIDOS SATISFACTORIAMENTE AL PREFIJO #{params[:empresa_transferir_gtin]}" } if params[:transferir]
      format.html { redirect_to "/empresas/#{params[:empresa_id]}/productos?eliminar=true", notice: "Los GTIN #{productos.collect{|producto| producto}} fueron eliminados." } if params[:transferir].nil?
    end
  end


  def import

        
        respond_to do |format|
         
        
          format.html{

            tipo_gtin = TipoGtin.find(params[:tipo_gtin])
            #CAmbio Plan de contingencia
            fecha_c = Time.parse(params[:fecha_creacion][0]) if !params[:fecha_creacion][0].empty?

            if (params[:tipo_gtin] == '6') or (params[:tipo_gtin] == '4') or (params[:tipo_gtin] == '5')  # Gtin14 base 8  /  GTIN14 base 13 / GTIN14 base 12
              codigo_invalido = Producto.import_gtin_14(params[:file].path, params[:file].original_filename, params[:tipo_gtin], params[:empresa_id], session[:usuario],  fecha_c)
              mensaje = "Los #{tipo_gtin.tipo} base #{tipo_gtin.base} fueron importados." 
            else # Importar GTIN-13
              
              # EL proceso de importar se ejecuta en background

              #Empresa.delay.importar_gtin_13(params[:file].path, params[:file].original_filename, params[:tipo_gtin], params[:empresa_id], session[:usuario])
              Empresa.importar_gtin_13(params[:file].path, params[:file].original_filename, params[:tipo_gtin], params[:empresa_id], session[:usuario], fecha_c)
             
            end

             if (codigo_invalido == "")

               redirect_to "/empresas/#{params[:empresa_id]}/productos", notice: "Los Codigos fueron generados satisfactoriamente".upcase 
             else
              
              redirect_to "/empresas/#{params[:empresa_id]}/productos", notice: "No se pudo generar GTIN-14 para los siguientes codigo(s) [#{codigo_invalido}].".upcase 

               #redirect_to "/empresas/#{params[:empresa_id]}/productos?job=true&job_id=#{job.id}", notice:  "LOS PRODUCTOS SE ESTAN IMPORTANDO"  
             end
           
            
          }


        end

  end


  # DELETE /productos/1
  # DELETE /productos/1.json
  def destroy
    @producto = Producto.find(params[:id])
    @quantity = @producto.quantity
    @quantity.destroy
    @producto.destroy

    respond_to do |format|
      format.html { redirect_to productos_url }
      format.json { head :no_content }
    end
  end
  
  def registrar_gtin(producto)

    uri = "https://grp.gs1.org/grp-st/v3/gtins"
    if producto.img_url.present?
      body = [{
        "gtin"=> "0" + producto.gtin,
        "licenceKey"=> producto.prefijo,
        "licenceType"=> 'GCP',
        "gtinStatus"=> "ACTIVE",
        "brandName"=> [{
          "language"=> producto.has_country[0].country.lang_code,
          "value"=> producto.marca
        }],
        "gpcCategoryCode"=> producto.classification.code,
        "countryOfSaleCode"=> [
          producto.has_country[0].country.lang_code.split(/-/)[1]
        ],
        "productDescription"=> [
          {
            "language"=> producto.has_country[0].country.lang_code,
            "value"=> producto.descripcion
          }
        ],
        "productImageUrl"=> [{
          "language"=> producto.has_country[0].country.lang_code,
          "value"=> producto.img_url
        }],
        "netContent"=> [{
          "value"=> producto.quantity.units,
          "unitCode"=> producto.medida.codigo
        }]
      }]
    else
      body = [{
        "gtin"=> "0" + producto.gtin,
        "licenceKey"=> producto.prefijo,
        "licenceType"=> 'GCP',
        "gtinStatus"=> "ACTIVE",
        "brandName"=> [{
          "language"=> producto.has_country[0].country.lang_code,
          "value"=> producto.marca
        }],
        "gpcCategoryCode"=> producto.classification.code,
        "countryOfSaleCode"=> [
          producto.has_country[0].country.lang_code.split(/-/)[1]
        ],
        "productDescription"=> [
          {
            "language"=> producto.has_country[0].country.lang_code,
            "value"=> producto.descripcion
          }
        ],
        "netContent"=> [{
          "value"=> producto.quantity.units,
          "unitCode"=> producto.medida.codigo
        }]
      }]
    end

    res = make_post_request(uri,body)
    data = JSON.parse(res)
    puts "API | BATCH GS1 ----- " + data + " --------- "
    logger.info "API | BATCH GS1 ----- " + data + " --------- "
    return data
  end

  def make_post_request(uri, body)
    url = URI(uri)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    # Request headers
    request["Content-Type"] = "application/json"
    request['Cache-Control'] = 'no-cache'
    request['APIKey'] = '9f487becd353409c9ab8c711944ecb5e'
    request.body = JSON.dump(body)

    return https.request(request).body
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product      
      #@producto = Producto.where("gtin = ?", params[:id])
      @empresa = Empresa.find(:first, :conditions => ["prefijo = ?", params[:empresa_id]])
      @producto = Producto.find(:first, :conditions => ["gtin like ?", params[:id]? params[:id]:params[:gtin]])
      if @producto
        @selected = HasCountry.where("producto_id = ?", @producto.id)
      end
    end

    def set_countries
      @countries = Country.all.order(:name).to_a
    end

end
