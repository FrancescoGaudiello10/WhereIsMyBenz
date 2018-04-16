class RatingsController < ApplicationController
    def create
      @question = Question.find(params[:rating][:question_id])
      @rating = @question.ratings.create(rating_params)
      rating_num = @question.ratings.count();
      if rating_num > 0
        val_media = @question.ratings.sum(:stars) / rating_num
      else
        val_media = @rating.stars
      end
      @question.update_attribute(:valutation, val_media)
      current_user.ratings << @rating
      redirect_back(fallback_location: root_path)
    end
    
    def update
      rating = Rating.find(params[:id])
      if (rating.user_id != current_user.id)
        create
      else
        rating.update_attribute(:stars, params[:rating][:stars])
      end
      question = Question.find(rating.question_id)
      val_media = question.ratings.sum(:stars) / question.ratings.count()
      question.update_attribute(:valutation, val_media)
    end
    
    private
      def rating_params
        params.require(:rating).permit(:stars)
      end
end

