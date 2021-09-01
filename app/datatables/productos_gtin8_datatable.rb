#encoding: UTF-8
class ProductosGtin8Datatable 
  delegate :params, :h, :link_to,  to: :@view

   def initialize(view)
    
    @view = view
   end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: productos.count,
      iTotalDisplayRecords: productos.total_entries,      
      aaData: data
    }

  end

private

  def data

    productos.map do |producto|

      [ 
        producto.try(:empresa).try(:nombre_empresa),
        producto.prefijo,
        producto.try(:tipo_gtin).try(:tipo),
        producto.gtin,
        producto.quantity ? producto.descripcion + " " + producto.quantity.units + " " + producto.medida.abreviatura.upcase : producto.descripcion,
        producto.marca,
        producto.try(:estatus).try(:descripcion),
        producto.codigo_prod,
        producto.try(:classification_description),
        producto.try(:countries),
        if producto.origen == 1
          "Sistema de Gestion"
        else
          "Sistema de Solicitud"
        end,
        (producto.fecha_creacion) ? producto.fecha_creacion.strftime("%Y-%m-%d") : "",
        (producto.fecha_ultima_modificacion) ? producto.fecha_ultima_modificacion.strftime("%Y-%m-%d") : ""
      ]
      
    end

  end

  def productos

    productos ||= fetch_productos
  end

  def fetch_productos

    productos = Producto.where("id_tipo_gtin = 1").includes(:estatus, :tipo_gtin, :empresa, :classification, :has_country, :country).order("#{sort_column} #{sort_direction}") 
    productos = productos.page(page).per_page(per_page)

    productos = productos.where("empresa.nombre_empresa like :search  or empresa.prefijo like :search or tipo_gtin.tipo like :search or producto.gtin like :search or producto.descripcion like :search or producto.marca like :search or estatus.descripcion like :search or  producto.codigo_prod like :search or classifications.name like :search or countries.name like :search or producto.fecha_creacion like :search or producto.fecha_ultima_modificacion like :search", search: "%#{params[:sSearch]}%") if params[:sSearch].present?
    productos = productos.where("empresa.nombre_empresa like :search0", search0: "%#{params[:sSearch_0]}%" ) if params[:sSearch_0].present? # Filtro de busqueda por nombre empresa
    
    productos = productos.where("empresa.prefijo like :search1", search1: "%#{params[:sSearch_1]}%" ) if params[:sSearch_1].present? # Filtro PREFIJO
    
    productos = productos.where("producto.gtin like :search3", search3: "%#{params[:sSearch_3]}%" )  if params[:sSearch_3].present? #GTIN

    productos = productos.where("producto.descripcion like :search4", search4: "%#{params[:sSearch_4]}%" ) if params[:sSearch_4].present?  # descripcion de producto
  
    productos = productos.where("producto.marca like :search5", search5: "%#{params[:sSearch_5]}%" )     if params[:sSearch_5].present? # marca producto
    
    productos = productos.where("producto.codigo_prod like :search7", search7: "%#{params[:sSearch_7]}%" )     if params[:sSearch_7].present? # codigo producto
   
    productos = productos.where("classifications.name like :search8", search8: "%#{params[:sSearch_8]}%" )     if params[:sSearch_8].present? # classification

    productos = productos.where("countries.name like :search9", search9: "%#{params[:sSearch_9]}%") if params[:sSearch_9].present? # Paises comercializacion

    productos = productos.where("CONVERT(varchar(255),  producto.fecha_creacion ,126) like :search11", search11: "%#{params[:sSearch_11]}%")  if params[:sSearch_11].present? # fecha creacion
    
    productos = productos.where("CONVERT(varchar(255),  producto.fecha_ultima_modificacion ,126) like :search12", search12: "%#{params[:sSearch_12]}%") if params[:sSearch_12].present? # fecha modificacion
    

    productos
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page


    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 100
  end

  def sort_column

     columns = %w[empresa.nombre_empresa empresa.prefijo tipo_gtin.tipo producto.gtin producto.descripcion producto.marca estatus.descripcion producto.codigo_prod classifications.name countries.name producto.origen producto.fecha_creacion producto.fecha_ultima_modificacion]
     columns[params[:iSortCol_0].to_i]

  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  
end