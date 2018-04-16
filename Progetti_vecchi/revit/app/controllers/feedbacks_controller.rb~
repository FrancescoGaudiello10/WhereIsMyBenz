class FeedbacksController < ApplicationController
    def new
    @feedback = Feedback.new
    end
    def create
        params[:giver_id]=current_user.id
        @user=User.find(params[:receiver_id])
        @feedback= Feedback.new(feedback_params)
        @user.passive_feedbacks<<@feedback
        current_user.active_feedbacks<<@feedback
       #
        #@feedback=Feedback.new(feedback_params)
    if @feedback.save
      #flash[:success] = "item created!"
      redirect_to @user#show
    else
      
      redirect_to :root
    end

   
    end
    private
       def feedback_params
        params.permit(:value,:receiver_id,:giver_id) 
        
    end
end
