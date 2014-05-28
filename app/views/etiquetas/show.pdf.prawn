pdf.image "#{Rails.root}/app/assets/images/gs1-logohome", :scale => 0.50
items =  [["Nombre","#{@contacto.nombre_contacto}"], ["Cargo", "#{@contacto.cargo_contacto}"], ["Telefono","#{@contacto.contacto}"], ["Edificio", "#{@etiqueta.edificio}"], ["Calle", "#{@etiqueta.calle}"], ["Urbanizacion", "#{@etiqueta.urbanizacion}"], ["Estado", "#{@etiqueta.estado.nombre}"], ["Ciudad", "#{@etiqueta.ciudad.nombre}"], ["Municipio","#{@etiqueta.try(:municipio).try(:nombre)}"], ["Parroquia", "#{@etiqueta.try(:parroquia).try(:nombre)}"], ["Código Postal", "#{@etiqueta.cod_postal}"], ["Punto Referencia", "#{@etiqueta.punto_referencia}"]]
pdf.table items