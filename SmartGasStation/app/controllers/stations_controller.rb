class StationsController < ApplicationController
    before_action :set_station, only: [:show, :edit, :update, :destroy]
    #autenticazione richiesta
    before_action :authenticate_user! #, :admin_user, only: :index
    #solo gli amministratori possono modificare o cancellare stazioni
    before_action :admin_user, only: [:new, :edit, :update, :destroy]

    # GET /stations
    # GET /stations.json
    def index
        @station = Station.all
    end

    # GET /stations/1
    # GET /stations/1.json
    def show
        @station = Station.find(params[:id])
        @coord = Geocoder.coordinates(@station.Indirizzo)
        @lat = @coord[0]
        @long = @coord[1]
    end

    # GET /stations/new
    def new
        @station = Station.new
        @stazioni = Implant
                        .select('Bandiera')
                        .from('implants')
                        .group('Bandiera')
                        .order('Bandiera ASC')
                        .pluck("Bandiera") #converte in array
    end

    # GET /stations/1/edit
    def edit
        @station = Station.find(params[:id])
    end

    # POST /stations
    # POST /stations.json
    def create
        @station = Station.new(station_params)

        # if @station.save #salva nel database, valore booleano
        #             redirect_to @station
        #         else
        #             render 'new'
        #         end

        respond_to do |format|
            if @station.save
                format.html {redirect_to @station, notice: 'Station was successfully created.'}
                format.json {render :show, status: :created, location: @station}
            else
                format.html {render :new}
                format.json {render json: @station.errors, status: :unprocessable_entity}
            end
        end
    end

    # PATCH/PUT /stations/1
    # PATCH/PUT /stations/1.json
    def update

        if @station.update(article_params)
            redirect_to @station
        else
            render 'edit'
        end

        respond_to do |format|
            if @station.update(station_params)
                format.html {redirect_to @station, notice: 'Station was successfully updated.'}
                format.json {render :show, status: :ok, location: @station}
            else
                format.html {render :edit}
                format.json {render json: @station.errors, status: :unprocessable_entity}
            end
        end
    end

    # DELETE /stations/1
    # DELETE /stations/1.json
    def destroy
        @station.destroy
        respond_to do |format|
            format.html {redirect_to stations_url, notice: 'Station was successfully destroyed.'}
            format.json {head :no_content}
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_station
        @station = Station.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def station_params
        params.require(:station).permit(:Bandiera, :Nome, :Indirizzo, :Benzina, :Diesel, :Super, :Excellium, :Metano, :GPL, :allDay, :Self, :autoLavaggio)
    end

    # https://stackoverflow.com/a/18821972/1440037
    def admin_user
        redirect_to stations_path, notice: "Solo i gestori possono compiere questa azione." unless current_user.admin?
        #flash[:error] = "Solo i gestori possono compiere questa azione."  unless current_user.admin?
    end
end
