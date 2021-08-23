#encoding: UTF-8
class EmpresaRegistradasDatatable 
  delegate :params, :h, :link_to, :content_tag, to: :@view

   def initialize(view, perfil, gerencia)
    @view = view
    @perfil = perfil
    @gerencia = gerencia
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

      boton = ""
      
      if params[:activar_empresa] ## Asignar prefijo a la empresa
        
        boton = link_to(( content_tag(:span, '',:class => 'ui-icon ui-icon-extlink')+'Activar').html_safe, "/empresa_registradas/#{empresa.id}/edit?activar_empresa=true", {:class => "ui-state-default ui-corner-all botones_servicio", :title => "Activar la empresa #{empresa.nombre_empresa}"})  
      
      else # Sino se esta activando la empresa entonces esta editando -si se tiene el privilegio, en caso contrario no se muestra el boton para editar, caso asistente contable de administracion-
        
        if UsuariosAlcance.verificar_alcance(@perfil, @gerencia, 'Modificar Empresa Registrada')
          boton = link_to(( content_tag(:span, '',:class => 'ui-icon ui-icon-extlink')+'Editar').html_safe, "/empresa_registradas/#{empresa.id}/edit", {:class => "ui-state-default ui-corner-all botones_servicio", :title => "Editar la empresa #{empresa.nombre_empresa}"}) 
        end

      end
     
      [ 
        empresa.rif_completo,
        empresa.nombre_empresa,        
        (empresa.fecha_inscripcion)  ? empresa.fecha_inscripcion.strftime("%Y-%m-%d")  : "",
        empresa.ciudad_,
        empresa.sub_estatus_,
        empresa.tipo_usuario_empresa_,
        empresa.ventas_brutas_anuales,
        empresa.clasificacion_,
        empresa.escala,
        link_to(( content_tag(:span, '',:class => 'ui-icon ui-icon-extlink')+'Detalle').html_safe, "/empresa_registradas/#{empresa.id}", {:class => "ui-state-default ui-corner-all botones_servicio", :title => "Detalle de la empresa #{empresa.nombre_empresa}"}),
        boton 
      ]
    
    end

  end

  def empresas
    empresas ||= fetch_empresas
  end

  def fetch_empresas


    if params[:activar_empresa] 
      
      empresas = EmpresaRegistrada.where("rif IS NOT NULL and sub_estatus.descripcion = 'SOLVENTE'").joins(:ciudad, :clasificacion, :tipo_usuario_empresa, :sub_estatus).select("empresas_registradas.id, empresas_registradas.rif_completo, empresas_registradas.nombre_empresa,empresas_registradas.escala, empresas_registradas.fecha_inscripcion, ciudad.nombre as ciudad_, sub_estatus.descripcion as sub_estatus_, tipo_usuario_empresa.descripcion as tipo_usuario_empresa_, empresas_registradas.ventas_brutas_anuales, empresa_clasificacion.descripcion as clasificacion_").order("#{sort_column} #{sort_direction}") 
    else
      empresas = EmpresaRegistrada.where("rif IS NOT NULL").joins(:ciudad, :clasificacion, :tipo_usuario_empresa, :sub_estatus).select("empresas_registradas.id, empresas_registradas.rif_completo, empresas_registradas.nombre_empresa, empresas_registradas.escala, empresas_registradas.fecha_inscripcion, ciudad.nombre as ciudad_, sub_estatus.descripcion as sub_estatus_, tipo_usuario_empresa.descripcion as tipo_usuario_empresa_, empresas_registradas.ventas_brutas_anuales, empresa_clasificacion.descripcion as clasificacion_").order("#{sort_column} #{sort_direction}") 
      
    end

    empresas = empresas.page(page).per_page(per_page)

     if params[:sSearch].present? # Filtro de busqueda general
       empresas = empresas.where("empresas_registradas.nombre_empresa like :search or empresas_registradas.fecha_inscripcion like :search or  ciudad.nombre like :search or empresas_registradas.rif_completo or sub_estatus.descripcion like :search or empresas_registradas.ventas_brutas_anuales like :search", search: "%#{params[:sSearch]}%")
     end
   
     if params[:sSearch_1].present? # Filtro de busqueda por nombre de la empresa
        empresas = empresas.where("empresas_registradas.nombre_empresa like :search1", search1: "%#{params[:sSearch_1]}%" )
     end
    
   
     if params[:sSearch_3].present?
       empresas = empresas.where("ciudad.nombre like :search3", search3: "%#{params[:sSearch_3]}%" )
     end
     
     if params[:sSearch_2].present?
      
      empresas = empresas.where("CONVERT(varchar(255),  empresas_registradas.fecha_inscripcion ,126) like :search2", search2: "%#{params[:sSearch_2]}%")
      
     end

     if params[:sSearch_0].present?
       empresas = empresas.where("empresas_registradas.rif_completo like :search0", search0: "%#{params[:sSearch_0]}%" )
     end

     if params[:sSearch_5].present?
       empresas = empresas.where("tipo_usuario_empresa.descripcion like :search5", search5: "%#{params[:sSearch_5]}%" )
     end

     if params[:sSearch_4].present?
       empresas = empresas.where("sub_estatus.descripcion like :search4", search4: "%#{params[:sSearch_4]}%" )
     end

     if params[:sSearch_6].present?
       empresas = empresas.where("empresas_registradas.ventas_brutas_anuales like :search6", search6: "%#{params[:sSearch_6]}%" )
     end

     if params[:sSearch_7].present?
       empresas = empresas.where("empresa_clasificacion.descripcion like :search7", search7: "%#{params[:sSearch_7]}%" )
     end
     if params[:sSearch_8].present?
      empresas = empresas.where("empresas_registradas.escala = :search8", search8: params[:sSearch_8] )
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

     columns = %w[empresas_registradas.rif empresas_registradas.nombre_empresa empresas_registradas.escala empresas_registradas.fecha_inscripcion ciudad.nombre tipo_usuario_empresa.descripcion sub_estatus.descripcion empresas_registradas.ventas_brutas_anuales empresa_clasificacion.descripcion]
     columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "asc" ? "asc" : "desc"
  end

  
end
