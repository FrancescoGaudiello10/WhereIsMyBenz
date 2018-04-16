class PrenotationsController < ApplicationController
  before_action :set_prenotation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /prenotations
  # GET /prenotations.json
  def index
    @property = Property.find(params[:property_id])
    @prenotations = @property.prenotations
  end

  # GET /prenotations/new
  def new
    @property = Property.find(params[:property_id])
    @prenotation = Prenotation.new
  end

  # POST /prenotations
  # POST /prenotations.json
  def create
    @property = Property.find(params[:property_id])
    @prenotation = @property.prenotations.create(prenotation_params)

    respond_to do |format|
      if @prenotation.save
        format.html { redirect_to property_prenotations_path(@property), notice: 'Prenotazione effettuata con successo.' }
        format.json { render :show, status: :created, location: @prenotation }
      else
        format.html { render :new }
        format.json { render json: @prenotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prenotations/1
  # DELETE /prenotations/1.json
  def destroy
    @property = Property.find(params[:property_id])
    @prenotation.destroy
    respond_to do |format|
      format.html { redirect_to property_prenotations_path(@property), notice: 'Prenotazione eliminata con successo.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prenotation
      @prenotation = Prenotation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prenotation_params
      params.require(:prenotation).permit(:name, :start_time, :end_time)
    end
end
