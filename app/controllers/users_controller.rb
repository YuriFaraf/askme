class UsersController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://goodprogrammer.ru/system/avatars/000/000/001/9a01a7b3165a3d0235e81bd678e47b5ae5224770_x300.jpg'
    )
  end
end
