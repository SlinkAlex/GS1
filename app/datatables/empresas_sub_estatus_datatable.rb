class EmpresasSubEstatusDatatable 
  delegate :params, :h, :link_to,  to: :@view

   def initialize(view)
    @view = view
   end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: empresas.count,
      iTotalDisplayRecords: empresas.total_entries,      
      aaData: data
    }

  end

private

  def data

    empresas.map do |empresa|
      
        [ 
          check_box_tag("sub_estatus_empresas[]", "#{empresa.prefijo}", false, :class=>"retirar_empresa"),
          empresa.prefijo,
          empresa.nombre_empresa,
          (empresa.fecha_inscripcion) ? empresa.fecha_inscripcion.strftime("%Y-%m-%d") : "",
          empresa.ciudad.nombre,
          empresa.rif,
          empresa.estatus.descripcion.upcase,
          select_tag("#{empresa.prefijo}", options_from_collection_for_select(SubEstatus.all, "id", "descripcion", empresa.try(:id_subestatus)), :id => "#{empresa.prefijo}sub_estatus"),
          link_to(( content_tag(:span, '',:class => 'ui-icon ui-icon-extlink')+'Detalle').html_safe, empresa_path(empresa),  {:class => "ui-state-default ui-corner-all botones_servicio", :title => "Detalle de la empresa #{empresa.nombre_empresa}"})
                   
        ]
    
    end

  end

  def empresas
    empresas ||= fetch_empresas
  end

  def fetch_empresas
   
    empresas = Empresa.where("estatus.descripcion = ?", 'Activa').includes(:estado, :ciudad, :estatus, :sub_estatus).order("#{sort_column} #{sort_direction}") 
    empresas = empresas.page(page).per_page(per_page)
    
    if params[:sSearch].present? # Filtro de busqueda general
      empresas = empresas.where("empresa.prefijo like :search or  empresa.nombre_empresa like :search or empresa.fecha_inscripcion like :search or  ciudad.nombre like :search or empresa.rif like :search or sub_estatus.descripcion like :search ", search: "%#{params[:sSearch]}%")
    end
    if params[:sSearch_0].present? # Filtro de busqueda prefijo
      empresas = empresas.where("empresa.prefijo like :search0", search0: "%#{params[:sSearch_0]}%" )
    end
    if params[:sSearch_1].present? # Filtro de busqueda por nombre de la empresa
      empresas = empresas.where("empresa.nombre_empresa like :search1", search1: "%#{params[:sSearch_1]}%" )
    end
    if params[:sSearch_2].present? # Filtro fecha_inscripcion
      empresas = empresas.where("empresa.fecha_inscripcion like :search2", search2: "%#{params[:sSearch_2]}%" )
    end
   
    if params[:sSearch_3].present?
      empresas = empresas.where("ciudad.nombre like :search3", search3: "%#{params[:sSearch_3]}%" )
    end
    if params[:sSearch_4].present?
      empresas = empresas.where("empresa.rif like :search4", search4: "%#{params[:sSearch_4]}%" )
    end

    if params[:sSearch_6].present?
      empresas = empresas.where("sub_estatus.descripcion like :search6", search6: "%#{params[:sSearch_6]}%" )
    end
  

    empresas
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 100
  end

  def sort_column

     columns = %w[empresa.prefijo empresa.nombre_empresa empresa.fecha_inscripcion ciudad.nombre empresa.rif estatus.descripcion sub_estatus.descripcion]
     columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "asc" ? "asc" : "desc"
  end

  
end