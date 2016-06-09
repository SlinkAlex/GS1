class TarifasController < ApplicationController
  def index
    @tarifas = Tarifa.all
    @tarifa = Tarifa.where("id_tipo_usuario = ?", params[:usuario]) if (params[:usuario])
    #@tarifa = Tarifa.where("id_tipo_usuario = ?", "No Usuario") if ((params[:usuario]) and (params[:usuario]=='2'))

    puts "TIPO USUAIRIO "+params[:usuario].inspect
    puts "USUARIO "+@tarifa.inspect

    @tarifa = Tarifa.find(params[:id]) if params[:id]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tarifa }
    end

  end

  def create
    @tarifa = Tarifa.new(params[:tarifa])

    respond_to do |format|
      if @tarifa.save
        format.html { redirect_to tarifas_path, notice: "Tarifa creada correctamente"}
      else
        format.html { render action: "new" }
      end
    end
  end

  def new
    @tarifa = Tarifa.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tarifa }
    end
  end

  def edit
    @tarifa = Tarifa.find(params[:id])
  end

  def show
    @tarifa = Tarifa.find( :conditions =>["id_tipo_usuario = ?", params[:tipo_usuario]]) if (params[:tipo_usuario])
    puts "USUARIOooo "+@tarifa.inspect
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tarifa }
    end
  end

  def update
    @tarifa = Tarifa.find(params[:id])
    respond_to do |format|
      if @tarifa.update_attributes(params[:tarifa])
        format.html { redirect_to  tarifas_path, notice: "Tarifa  modificado correctamente" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tarifa.errors, status: :unprocessable_entity }
      end
    end


  end

  def destroy
    @tarifa = Tarifa.find(params[:id])
    @tarifa.destroy

    respond_to do |format|
      format.html { redirect_to tarifas_url }
      format.json { head :no_content }
    end
  end
end
