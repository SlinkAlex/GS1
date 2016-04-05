#encoding: UTF-8
class EtiquetaPdf < Prawn::Document

  def initialize(empresa, telefono)
    super(:page_layout => :portrait,:margin => [5, 3], :page_size => [235, 110])

    font("#{Rails.root}/fonts/arial.ttf", :size => 8) do

      draw_text "#{empresa.nombre_empresa.strip}", :at  => [0,85]
      draw_text "Contacto: #{empresa.rep_ean.strip.upcase}", :at => [0,75]
      draw_text "Cargo: #{empresa.rep_ean_cargo.strip}", :at => [0,67]
      draw_text "Dirección:", :at => [0,59]
      text_box("#{empresa.direccion_ean.strip}", options={:at => [40,65], :width  =>200})
      draw_text "Pto Ref: #{empresa.try(:punto_ref_ean)}", :at => [0,37]
      draw_text "Estado: #{empresa.try(:estado).try(:nombre)}", :at => [0,29]
      draw_text "Ciudad: #{empresa.try(:ciudad).try(:nombre).upcase}", :at => [60,29]
      draw_text "Municipio: #{empresa.try(:municipio).try(:nombre)}", :at => [0,21]
      draw_text "Parroquia: #{empresa.try(:parroquia_ean)}", :at => [60,21]
      draw_text "C. Postal: #{empresa.try(:cod_postal_ean).strip}", :at => [0,13]
      draw_text "Código: #{empresa.prefijo}", :at => [60,13]
      draw_text "Teléfonos #{telefono}", :at => [0,5]




    end

  end

end
