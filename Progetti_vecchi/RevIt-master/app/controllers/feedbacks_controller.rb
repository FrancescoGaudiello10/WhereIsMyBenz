class FeedbacksController < ApplicationController
    before_action :exist_feedback , only: :create

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
       
       def exist_feedback
          @user =User.find(params[:receiver_id])
          if @user.passive_feedbacks.exists?(['giver_id LIKE ?',current_user.id])
            redirect_to user_path(@user)
          end
       end
end
