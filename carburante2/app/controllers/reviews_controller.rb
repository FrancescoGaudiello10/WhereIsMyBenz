class ReviewsController < ApplicationController
    def create
        @station = Station.find(params[:station_id])
        @review = @station.reviews.create(comment_params)
        redirect_to station_path(@station)
    end

    def destroy
        @station = Station.find(params[:station_id])
        @review = @station.reviews.find(params[:id])
        @comment.destroy
        redirect_to station_path(@station)
    end

    private
    def comment_params
        params.require(:review).permit(:commenter, :body, :stars)
    end
end
