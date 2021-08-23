 #encoding: UTF-8
class ReporteProductosPdf < Prawn::Document	
	

	def initialize(nombre_empresa, prefijo, tipo_gtin, gtin, descripcion,marca, codigo_producto, clasificacion, pais, fecha_creacion, fecha_modificacion, estatus, filtro_general)

		super(:top_margin => 10, :page_layout => :landscape)
		
		productos = Producto.includes(:estatus, :tipo_gtin, :empresa, :classification, :has_country, :country).limit(5).order("empresa.prefijo")

		productos = productos.where("empresa.nombre_empresa like '%#{params[:nombre_empresa]}%'") if params[:empresa] != ''
		productos = productos.where("empresa.prefijo = #{params[:prefijo]}") if params[:prefijo] != ''
		productos = productos.where("tipo_gtin.tipo like '%#{params[:tipo_gtin]}%'") if params[:tipo_gtin] != ''
		productos = productos.where("producto.gtin like '%#{params[:gtin]}%'") if params[:gtin]
		productos = productos.where("producto.descripcion like '%#{params[:descripcion]}%'") if params[:descripcion] != ''
		productos = productos.where("producto.marca like '%#{params[:marca]}%'" ) if params[:marca] != ''
		productos = productos.where("estatus.descripcion like '%#{params[:estatus]}%'") if params[:estatus] != ''
		productos = productos.where("producto.codigo_prod like '%#{params[:codigo_producto]}%'") if params[:codigo_producto] != ''
		productos =productos.where("classifications.name like :search8", search8: "%#{params[:clasificacion]}%" )     if params[:clasificacion].present? # classification
		productos =productos.where("classifications.name like :search8", search8: "%#{params[:pais]}%" )     if params[:pais].present? # Paises Comercialización
		productos = productos.where("CONVERT(varchar(255),  producto.fecha_creacion ,126) like '%#{params[:fecha_creacion]}%'")  if params[:fecha_creacion] != ''
		productos = productos.where("CONVERT(varchar(255),  producto.fecha_ultima_modificacion ,126) like '%#{params[:fecha_ultima_modificacion]}%'") if params[:fecha_ultima_modificacion] != ''


		

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