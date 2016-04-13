#encoding: UTF-8
class EtiquetaPdf < Prawn::Document

  def initialize(empresa, telefono)
    super(:page_layout => :portrait,:margin => [0, 15], :page_size => [275, 130])

    font("#{Rails.root}/fonts/arial.ttf", :size => 9) do

      draw_text "#{empresa.nombre_empresa.strip}", :at  => [0,100]
      draw_text "Contacto: #{empresa.rep_ean.strip.upcase}", :at => [0,90]
      draw_text "Cargo: #{empresa.rep_ean_cargo.strip}", :at => [0,80]
      draw_text "Dirección:", :at => [0,70]
      text_box("#{empresa.direccion_ean.strip}", options={:at => [40,75], :width  =>220})
      draw_text "Pto Ref: #{empresa.try(:punto_ref_ean)}", :at => [0,50]
      draw_text "Estado: #{empresa.try(:estado).try(:nombre)}", :at => [0,40]
      draw_text "Ciudad: #{empresa.try(:ciudad).try(:nombre).upcase}", :at => [100,40]
      draw_text "Municipio: #{empresa.try(:municipio).try(:nombre)}", :at => [0,30]
      draw_text "Parroquia: #{empresa.try(:parroquia_ean)}", :at => [100,30]
      draw_text "C. Postal: #{empresa.try(:cod_postal_ean).strip}", :at => [0,20]
      draw_text "Código: #{empresa.prefijo}", :at => [100,20]
      draw_text "Teléfonos #{telefono}", :at => [0,10]




    end

  end

end
