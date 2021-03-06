 #encoding: UTF-8
class ProductosPdf < Prawn::Document	
	

	def initialize(empresa, tipo_gtin, gtin, descripcion,marca, codigo_producto, fecha_creacion, fecha_modificacion)	
		
		super(:top_margin => 10, :page_layout => :portrait)

 		productos = Producto.where("prefijo = ? ",empresa).includes(:estatus, :tipo_gtin).order("producto.fecha_creacion desc")   
		productos = productos.where("tipo_gtin.tipo like :search", search: "%#{tipo_gtin}%") if tipo_gtin != ''
		productos = productos.where("producto.gtin like :search", search: "%#{gtin}%" ) if gtin != ''
		productos = productos.where("producto.descripcion like :search", search: "%#{descripcion}%" ) if descripcion != ''
		productos = productos.where("producto.marca like :search", search: "%#{marca}%" ) if marca != ''

		productos = productos.where("producto.codigo_prod like :search", search: "%#{codigo_producto}%" ) if codigo_producto != ''
		productos = productos.where("CONVERT(varchar(255),  producto.fecha_creacion ,126) like :search", search: "%#{fecha_creacion}%") if fecha_creacion != ''
		productos = productos.where("CONVERT(varchar(255),  producto.fecha_ultima_modificacion ,126) like :search", search: "%#{fecha_modificacion}%") if fecha_modificacion != '' 
		font("#{Rails.root}/fonts/arial.ttf", :size => 10) do

			productos_arreglo = [["MARCA", "DESCRIPCION", "GTIN", "TIPO GTIN"]]

			productos.each do |producto|
				
				cadena = producto.descripcion.upcase.split(" X ")
				cadena_final = ""
				for index in 1..cadena.count-1
					if cadena[index].include?("UND")
					if !cadena_final.include?("UND")
						cadena_final = producto.quantity ? cadena_final + " " + producto.quantity.units + " " + producto.medida.abreviatura.upcase + " X " + cadena[index] : cadena_final + ' X ' + cadena[index]
					else
						cadena_final = cadena_final + ' X ' + cadena[index]
					end 
					else
					cadena_final = cadena_final + ' X ' + cadena[index]
					end
				end

				if producto.tipo_gtin.tipo == "GTIN-13" || producto.tipo_gtin.tipo == "GTIN-8"
					descripcion = producto.quantity ? producto.descripcion + " " + producto.quantity.units + " " + producto.medida.abreviatura.upcase : producto.descripcion
				else
					descripcion = cadena[0] + cadena_final
				end

				productos_arreglo << [ producto.marca, descripcion, producto.gtin, producto.try(:tipo_gtin).try(:tipo)]
			end

			text ""
			move_down 10
			text "Fecha del Reporte:      #{Time.now.strftime("%d/%m/%Y")}", :size => 9, :align => :right


			move_down 30
			text ""
			text "#{empresa.nombre_empresa.strip}", :size => 12, :align => :center

			image "#{Rails.root}/app/assets/images/Gs1Vzla.png", :at => [0, 750], :height => 40

			#number_pages "Pagina <page> de <total>", :size => 9, :at => [480, 720]
			move_down 10
			 table(productos_arreglo,  :row_colors => ["FFFFFF", "DDDDDD"], :cell_style => { size: 8, :align => :center }, :header => true, :position => :center)
				move_down 10
			 text "Total productos: #{productos.size}", :size => 9, :align => :left
		end
		
	end

end