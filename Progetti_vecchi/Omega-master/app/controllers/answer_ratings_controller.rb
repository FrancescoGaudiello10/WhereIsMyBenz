class AnswerRatingsController < ApplicationController
  def create
    @answer = Answer.find(params[:answer_rating][:answer_id])
    @rating = @answer.answer_rating.create(:stars => 1)
    valutation = @answer.valutation + 1
    @answer.update_attribute(:valutation, valutation)
    current_user.answer_rating << @rating
    redirect_back(fallback_location: root_path)
  end
    
  def update
    @answer = Answer.find(params[:answer_rating][:answer_id])
    rating = AnswerRating.find_by(:id => params[:id])
    if rating
      destroy
    else
      create
    end
  end
  
  def destroy
    @answer = Answer.find(params[:answer_rating][:answer_id])
    @rating = AnswerRating.find_by(:id => params[:id])
    @rating.destroy
    valutation = @answer.valutation - 1
    @answer.update_attribute(:valutation, valutation)
    redirect_back(fallback_location: root_path)
  end
  
  private
    def answer_rating_params
      params.require(:answer_rating).permit(:stars)
    end
end
