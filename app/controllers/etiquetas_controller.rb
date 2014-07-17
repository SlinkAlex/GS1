class EtiquetasController < ApplicationController
  
  before_filter :require_authentication
  prawnto :prawn => { :top_margin => 10, :left_margin => 10, :page_layout => :landscape, :page_size => [279, 267]} 
  
  def show

    @etiqueta = Correspondencia.find(:first, :conditions => ["prefijo = ?", params[:id]], :include => :empresa)
    @contacto = DatosContacto.find(:first, :conditions => ["prefijo = ? and tipo = ?", params[:empresa_id], 'principal'])
    @navegabilidad = @etiqueta.try(:empresa).try(:nombre_empresa) 
    @navegabilidad = @navegabilidad ? @navegabilidad += " > Etiqueta" : ""

    respond_to do |format|
      format.html # show.html.haml
      format.pdf{}

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
    @empresa = Empresa.find(:first, :conditions => ["prefijo = ?", params[:empresa_id]])

    respond_to do |format|
        
      format.html { redirect_to empresa_etiqueta_path, notice: "Los datos para la etiqueta de la empresa #{@empresa.nombre_empresa} fueron modificados."}
     
    end
  end

end
