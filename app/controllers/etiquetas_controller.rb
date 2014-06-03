class EtiquetasController < ApplicationController
  
  before_filter :require_authentication
  
  
  prawnto :prawn => { :top_margin => 0 } # Marge superiori del documento pdf generado en este controlador
  
  def show

  	@etiqueta = Correspondencia.find(:first, :conditions => ["prefijo = ?", params[:id]], :include => :empresa)
    @contacto = DatosContacto.find(:first, :conditions => ["prefijo = ? and tipo = ?", params[:empresa_id], 'principal'])

    respond_to do |format|
      format.html # show.html.haml
      format.pdf{
      }
    end

  end

  # GET /empresa/:empresa_id/correspondencia/:id_correspondencia/edit
  def edit

    @empresa = Empresa.find(:first, :conditions => ["prefijo = ?", params[:empresa_id]])
    @etiqueta = Correspondencia.find(:first, :conditions => ["prefijo = ?", params[:empresa_id]])
    @contacto = DatosContacto.find(:first, :conditions => ["prefijo = ?", params[:empresa_id]])

  end


  def update

    Correspondencia.modificar_etiqueta(params)

    respond_to do |format|
        
      format.html { redirect_to empresa_etiqueta_path, notice: "La etiqueta para el prefijo #{params[:empresa_id]} fue modificada correctamente." }
     
    end
  end

end