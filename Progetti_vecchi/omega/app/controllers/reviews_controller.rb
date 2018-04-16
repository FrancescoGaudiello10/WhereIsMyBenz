class ReviewsController < ApplicationController

  def new
    @property = Property.find(params[:property]) #realizzato tramite "new_review_path(:property => @property)" nella link_to
    @review = Review.new
  end

  def create
    @property = Property.find(params[:property_id])
    @review = @property.reviews.create(reviews_params)
    @review.user_id = current_user.id
    if @review.valid?
      current_user.reviews << @review
      redirect_to property_path(@property)
    else
      render 'new'
    end
  end

  def destroy
    @property = Property.find(params[:property_id])
    @review = @property.reviews.find(params[:id])
    @review.destroy
    redirect_to property_path(@property)
  end

  private
    def reviews_params
      params.require(:review).permit(:title, :body, :valutation)
    end
end
