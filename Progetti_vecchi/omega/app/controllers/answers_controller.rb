class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    @answer.update_attribute(:valutation, 0)
    current_user.answers << @answer
    redirect_to property_question_path(@question, @question.property)
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to property_question_path(@question, @question.property)
  end

  private
    def answer_params
      params.require(:answer).permit(:body,:valutation)
    end
end
