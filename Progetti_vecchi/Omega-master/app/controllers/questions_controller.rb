class QuestionsController < ApplicationController

  def new
    @property = Property.find(params[:property])
    @question = Question.new
  end

  def create
    @property = Property.find(params[:property_id])
    @question = @property.questions.create(question_params)
    @question.user_id = current_user.id
    @question.update_attribute(:valutation, 0)
    if @question.valid?
      current_user.questions << @question
      redirect_to property_path(@property)
    else
      render 'new'
    end
  end

  def destroy
    @property = Property.find(params[:property_id])
    @question = @property.questions.find(params[:id])
    @question.destroy
    redirect_to property_path(@property)
  end

 def show
    @property = Property.find(params[:id])
    @question = @property.questions.find(params[:property_id])
    @answer = @question.answers.order(:valutation).reverse
 end

 def update
    question = Question.find(params[:property_id])
    question.update_attribute(:valutation, question.valutation + 1)
 end


 private
    def question_params
      params.require(:question).permit(:body)
    end
end
