class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_path, alert: 'Вы уже зашли в систему.' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_path, alert: 'Вы уже зашли в систему.' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены!'
    else
      render 'edit'
    end
  end

  def edit
  end

  def destroy
    session[:user_id] = nil
    @user.questions.destroy_all
    @user.destroy
    flash[:success] = "Пользователь удален."
    redirect_to root_path
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @answers_count = @questions.where.not(answer: nil).count

    @new_question = @user.questions.build
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url, :color)
  end
end
