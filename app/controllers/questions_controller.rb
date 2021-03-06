class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, except: [:create]

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.author = current_user
    if @question.save
      redirect_to user_path(@question.user), notice: 'Вопрос успешно задан.'
    else
      render :edit
    end
  end

  def update
    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'Вопрос успешно сохранён.'
    else
      render :edit
    end
  end

  def destroy
    user = @question.user
    @question.destroy
    redirect_to user_path(user), notice: 'Вопрос успешно удалён.'
  end

  private

  def authorize_user
    reject_user unless @question.user == current_user
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    if current_user.present?
      if params[:question][:user_id].to_i == current_user.id
        params.require(:question).permit(:user_id, :text, :answer, :author_id)
      else
        params.require(:question).permit(:user_id, :text, :author_id)
      end
    else
      params.require(:question).permit(:user_id, :text)
    end
  end
end
