class ClassificationsController < ApplicationController
  before_action :set_classification, only: [:show, :edit, :update, :destroy]

  # GET /classifications
  def index
    @classifications = Classification.all
    respond_to do |format|
      format.html
      format.json {render json: @classifications}
    end
  end

  # GET /classifications/1
  def show
  end

  # GET /classifications/new
  def new
    @classification = Classification.new
  end

  # GET /classifications/1/edit
  def edit
  end

  # POST /classifications
  def create
    @classification = Classification.new(classification_params)

    if @classification.save
      redirect_to classifications_url, notice: 'La clasificación fue creada correctamente.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /classifications/1
  def update
    if @classification.update(classification_params)
      redirect_to classifications_url, notice: 'La clasificación fue actualizada correctamente.'
    else
      render action: 'edit'
    end
  end

  # DELETE /classifications/1
  def destroy
    @classification.destroy
    redirect_to classifications_url, notice: 'La clasificación fue eliminada correctamente.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classification
      @classification = Classification.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def classification_params
      params.require(:classification).permit(:code, :name)
    end
end
