class MedidasController < ApplicationController
    before_action :set_medida, only: [:show, :edit, :update, :destroy]
  
    # GET /medidas
    def index
      @medidas = Medida.all
      respond_to do |format|
        format.html
        format.json {render json: @medidas}
      end
    end
  
    # GET /medidas/1
    def show
    end
  
    # GET /medidas/new
    def new
      @medida = Medida.new
    end
  
    # GET /medidas/1/edit
    def edit
    end
  
    # POST /medidas
    def create
      @medida = Medida.new(medida_params)
  
      if @medida.save
        redirect_to medidas_url, notice: 'La medida fue creada correctamente.'
      else
        render action: 'new'
      end
    end
  
    # PATCH/PUT /medidas/1
    def update
      if @medida.update(medida_params)
        redirect_to medidas_url, notice: 'La medida fue actualizada correctamente.'
      else
        render action: 'edit'
      end
    end
  
    # DELETE /medidas/1
    def destroy
      @medida.destroy
      redirect_to medidas_url, notice: 'La medida fue eliminada correctamente.'
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_medida
        @medida = Medida.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def medida_params
        params.require(:medida).permit(:nombre, :codigo, :abreviatura)
      end
  end
  