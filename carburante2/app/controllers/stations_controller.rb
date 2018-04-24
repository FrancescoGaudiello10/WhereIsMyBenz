class StationsController < ApplicationController
    def new

    end

    def create
        render plain: params[:station].inspect #The params method is the object which represents the parameters (or fields) coming in from the form
    end
end
