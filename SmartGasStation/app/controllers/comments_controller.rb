class CommentsController < ApplicationController

    def create
        @parent = parent

        @comment = @parent.comments.new comment_params
        @comment.save! #salva il commento mostrando eventuali eccezioni

        #Ricarica la pagina attuale per mostrare il commento
        redirect
    end

    def destroy
        @parent  = parent
        @comment = @parent.comments.find params[:id]
        @comment.destroy
        redirect
    end

    private

    def comment_params
        params.require(:comment).permit(:title, :body)#.merge(user_id: current_user.id)
    end

    # https://stackoverflow.com/a/35037494/1440037
    def parent
        Implant.find params[:implant_id] if params[:implant_id]
        Station.find params[:station_id] if params[:station_id]
    end

    def redirect
        redirect_to implant_path(@parent) if params[:implant_id]
        redirect_to station_path(@parent) if params[:station_id]
    end

end
