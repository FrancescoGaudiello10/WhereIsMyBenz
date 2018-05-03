class CommentsController < ApplicationController

    def create
        @station = Station.find(params[:station_id])
        @comment = @station.comments.create(comment_params)
        redirect_to station_path(@station)
    end

    def destroy
        @station = Station.find(params[:station_id])
        @comment = @station.comments.find(params[:id])
        @comment.destroy
        redirect_to station_path(@station)
    end

    private
    def comment_params
        params.require(:comment).permit(:commenter, :body, :stars)
    end

end
