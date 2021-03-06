class CiudadesController < ApplicationController
	def index
    	@ciudades = Ciudad.where("id_estado = ?", params[:id_estado]).order("nombre ASC")
    	respond_to do |format|
      		# JSON que maneja las ciudades dado un esatdo seleccionado
      		format.json { render json: @ciudades}
      	end
    end


    def show

    	@ciudad = Ciudad.find(params[:id])
    	respond_to do |format|
      		# JSON que maneja las ciudades dado un esatdo seleccionado
      		format.json { render json: @ciudad}
      	end

    end

end
