 #encoding: UTF-8
class ReporteProductosPdf < Prawn::Document	
	

	def initialize(nombre_empresa, prefijo, tipo_gtin, gtin, descripcion,marca, codigo_producto, clasificacion, pais, fecha_creacion, fecha_modificacion, estatus, filtro_general)

		super(:top_margin => 10, :page_layout => :landscape)
		
		productos = Producto.includes(:estatus, :tipo_gtin, :empresa, :classification, :has_country, :country).order("empresa.prefijo")

		productos = productos.where("empresa.nombre_empresa like '%#{nombre_empresa}%'") if nombre_empresa != ''
		productos = productos.where("empresa.prefijo = #{prefijo}") if prefijo != ''
		productos = productos.where("tipo_gtin.tipo like '%#{tipo_gtin}%'") if tipo_gtin != ''
		productos = productos.where("producto.gtin like '%#{gtin}%'") if gtin
		productos = productos.where("producto.descripcion like '%#{descripcion}%'") if descripcion != ''
		productos = productos.where("producto.marca like '%#{marca}%'" ) if marca != ''
		productos = productos.where("estatus.descripcion like '%#{estatus}%'") if estatus != ''
		productos = productos.where("producto.codigo_prod like '%#{codigo_producto}%'") if codigo_producto != ''
		productos =productos.where("classifications.name like :search8", search8: "%#{clasificacion}%" )     if clasificacion.present? # classification
		productos =productos.where("classifications.name like :search8", search8: "%#{pais}%" )     if pais.present? # Paises Comercialización
		productos = productos.where("CONVERT(varchar(255),  producto.fecha_creacion ,126) like '%#{fecha_creacion}%'")  if fecha_creacion != ''
		productos = productos.where("CONVERT(varchar(255),  producto.fecha_ultima_modificacion ,126) like '%#{fecha_modificacion}%'") if fecha_modificacion != ''


		

		font("#{Rails.root}/fonts/arial.ttf", :size => 10) do

			productos_arreglo = [["EMPRESA", "PREFIJO", "TIPO GTIN", "GTIN",  "DESCRIPCION", "MARCA", "ESTATUS", "CODIGO", "CLASIFICACION", "PAISES COMERCIALIZACION","FECHA CREACION"]]


			productos.each do |producto| 
				productos_arreglo << [producto.try(:empresa).try(:nombre_empresa).strip, producto.prefijo, producto.tipo_gtin.tipo, producto.gtin, producto.descripcion, producto.marca, producto.estatus.descripcion, producto.codigo_prod,producto.try(:classification_description), producto.try(:countries), producto.fecha_creacion.strftime("%Y-%m-%d")]

			end

			

			text ""
			move_down 10
			text "Fecha del Reporte:      #{Time.now.strftime("%d/%m/%Y")}", :size => 9, :align => :right


			move_down 30
			text ""
			text "Reporte General Productos", :size => 12, :align => :center

			image "#{Rails.root}/app/assets/images/Gs1Vzla.png", :at => [0, 750], :height => 40

			#number_pages "Pagina <page> de <total>", :size => 9, :at => [480, 720]
			move_down 10
			 table(productos_arreglo,  :row_colors => ["FFFFFF", "DDDDDD"], :cell_style => { size: 8, :align => :center }, :header => true, :position => :center)
				move_down 10
			 text "Total productos: #{productos.size}", :size => 9, :align => :left
		end
		
	end

end