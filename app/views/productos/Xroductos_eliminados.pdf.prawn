if params[:tipo_gtin] != ''
  @productos = @productos.where("tipo_gtin.tipo like :search", search: "%#{params[:tipo_gtin]}%" )
end

if params[:gtin] != ''
  @productos = @productos.where("producto_eliminado.gtin like :search", search: "%#{params[:gtin]}%" )
end

if params[:descripcion] != ''
  @productos = @productos.where("producto_eliminado.descripcion like :search", search: "%#{params[:descripcion]}%" )
end

if params[:marca] != ''
  @productos = @productos.where("producto_eliminado.marca like :search", search: "%#{params[:marca]}%" )
end

if params[:codigo_producto] != ''
  @productos = @productos.where("producto_eliminado.codigo_prod like :search", search: "%#{params[:codigo_producto]}%" )
end

if params[:fecha_creacion] != ''
  @productos = @productos.where("producto_eliminado.fecha_creacion like :search", search: "%#{params[:fecha_creacion]}%" )
end

if params[:fecha_eliminacion] != ''
  @productos = @productos.where("producto_elim_detalle.fecha_eliminacion like :search", search: "%#{params[:fecha_eliminacion]}%" )
end

if params[:subestatus] != ''
  @productos = @productos.where("sub_estatus.descripcion like :search", search: "%#{params[:subestatus]}%" )
end

if params[:motivo_retiro] != ''
  @productos = @productos.where("motivo_retiro.descripcion like :search", search: "%#{params[:motivo_retiro]}%" )
end

productos = Array.new
productos = [["Nombre Empresa","Tipo GTIN", "GTIN", "Descripción", "Marca", "Código Producto", "Fecha Creación", "Fecha Eliminación",  "Sub Estatus", "Motivo Retiro"]]

@productos.each do |producto|

  fecha = ""
  fecha =  producto.fecha_creacion.strftime("%Y-%m-%d") if (producto.fecha_creacion)
  nombre_empresa = (producto.try(:productos_empresa).try(:empresa_eliminada).try(:nombre_empresa)) ? producto.try(:productos_empresa).try(:empresa_eliminada).try(:nombre_empresa) : producto.try(:productos_empresa).try(:empresa).try(:nombre_empresa)
  productos << [nombre_empresa, producto.try(:tipo_gtin).try(:tipo), producto.gtin, producto.descripcion, producto.marca, producto.codigo_prod,fecha,producto.try(:producto_elim_detalle).try(:fecha_eliminacion).strftime("%Y-%m-%d"),producto.try(:producto_elim_detalle).try(:sub_estatus).try(:descripcion),producto.try(:producto_elim_detalle).try(:motivo_retiro).try(:descripcion) ]

end

draw_text "Empresa: #{@empresa.nombre_empresa}", :size => 8, :at => [0,735]
draw_text "Productos Eliminados", :size => 8, :at => [0,720]
draw_text "Fecha:#{Time.now.strftime("%Y-%m-%d")}", :size => 8, :at => [0,705]
move_down 50

#number_pages "(<page>/<total>)", :size => 9, :at => [700, 550]
table(productos,  :row_colors => ["FFFFFF", "DDDDDD"], :cell_style => { size: 8 }, :column_widths => [50,80,80,70,45,40])



