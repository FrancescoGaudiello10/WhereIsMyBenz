class CommentsController < ApplicationController

    #solo gli amministratori possono cancellare recensioni
    before_action   :admin_user, only:[:destroy]
  
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
    
    def admin_user
        s = Station.find(params[:station_id])
        redirect_to station_path(s), notice: "Solo i gestori possono compiere questa azione."  unless current_user.admin?
        #flash[:error] = "Solo i gestori possono compiere questa azione."  unless current_user.admin?
    end

end
