class EmpresaServiciosController < ApplicationController
  # GET /empresa_servicios
  # GET /empresa_servicios.json
  def index
    
    respond_to do |format|
      format.html {
                  if params[:eliminar]
                    render :template =>'/empresa_servicios/eliminar_empresa_servicios.html.haml'
                  elsif params[:eliminados]
                    render :template =>'/empresa_servicios/servicios_eliminados.html.haml'
                  else
                    render :template =>'/empresa_servicios/index.html.haml'
                  end
                   
      }
       format.json {
                    if params[:eliminar]
                      render json: (EliminarEmpresaServiciosDatatable.new(view_context))
                    elsif params[:eliminados]
                      render json: (EmpresaServiciosEliminadosDatatable.new(view_context))
                    else
                      render json: (EmpresaServiciosDatatable.new(view_context)) 
                    end
                    
                  }
    end
  end

  # GET /empresa_servicios/1
  # GET /empresa_servicios/1.json
  def show
    @empresa_servicio = EmpresaServicio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @empresa_servicio }
    end
  end

  # GET /empresa_servicios/new
  # GET /empresa_servicios/new.json
  def new
    @prefijo = params[:empresa_id]
    @empresa_servicio = EmpresaServicio.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @empresa_servicio }
    end
  end

  # GET /empresa_servicios/1/edit
  def edit
    
    @empresa_servicio = EmpresaServicio.find(params[:id])
    @servicio = Servicio.find(@empresa_servicio.id_servicio)

  end

  # POST /empresa_servicios
  # POST /empresa_servicios.json
  def create
    @prefijo = params[:empresa_servicio][:prefijo]
    @empresa_servicio = EmpresaServicio.new(params[:empresa_servicio])


    respond_to do |format|
      if @empresa_servicio.save
        
        format.html { redirect_to "/empresas/#{@prefijo}/empresa_servicios", notice: "El servicio a fue asociado a la empresa con prefijo #{@prefijo}"}
        
      else
        format.html { render action: "new" }
        format.json { render json: @empresa_servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /empresa_servicios/1
  # PUT /empresa_servicios/1.json
  def update
    
    @empresa_servicio = EmpresaServicio.find(params[:id])
    @servicio = Servicio.find(@empresa_servicio.id_servicio)

    respond_to do |format|
      if @empresa_servicio.update_attributes(params[:empresa_servicio])
         @servicio.update_attributes(params[:servicio])

        format.html { redirect_to "/empresas/#{params[:empresa_servicio][:prefijo]}/empresa_servicios", notice: "EL servicio #{params[:servicio][:nombre]} fue actualizado para la empresa con prefijo #{params[:empresa_servicio][:prefijo]}"}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @empresa_servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empresa_servicios/1
  # DELETE /empresa_servicios/1.json
  def destroy

    # Los nombre de los servicios
    servicios = ""
    params[:eliminar_servicios].collect{|id_servicio| empresa_servicio = EmpresaServicio.find(id_servicio); servicios += empresa_servicio.servicio.nombre +  " "}
    
    EmpresaServicio.eliminar(params) if params[:eliminar]
    respond_to do |format|
      format.html { redirect_to "/empresas/#{params[:empresa_id]}/empresa_servicios?eliminados=true", notice: "Los servicios #{servicios} fueron eliminados."}
    end
  end
end
