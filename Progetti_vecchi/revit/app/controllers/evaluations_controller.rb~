class EvaluationsController < ApplicationController
   before_action :exist_evaluation , only: :create    

   def new
    @evaluation = Evaluation.new
    end
    def create
        params[:evaluater_id]=current_user.id
        @owner=Owner.find(params[:evaluated_id])
        @evaluation= Evaluation.new(evaluation_params)
        @owner.passive_evaluations<<@evaluation
        current_user.active_evaluations<<@evaluation

    if @evaluation.save
      #flash[:success] = "item created!"
      redirect_to @owner#show
    else
      
      redirect_to :root
    end

   
    end
    private
       def evaluation_params
        params.permit(:value,:evaluated_id,:evaluater_id) 
       end  

       def exist_evaluation
         @owner=Owner.find(params[:evaluated_id])
         if @owner.passive_evaluations.exists?(['evaluater_id LIKE ?',current_user.id])
           redirect_to owner_path(@owner)
         end
       end
end
