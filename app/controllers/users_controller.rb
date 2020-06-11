class UsersController < ApplicationController
  def index
    @users = [
        User.new(
            id: 1,
            name: 'Vadim',
            username: 'installero',
            avatar_url: 'https://goodprogrammer.ru/system/avatars/000/000/001/9a01a7b3165a3d0235e81bd678e47b5ae5224770_x300.jpg'
        ),
        User.new(
            id: 2,
            name: 'Misha',
            username: 'aristofun'
        )
    ]
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

    @questions = [
        Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
        Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
        Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
        Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
        Question.new(text: 'В чём смысл жизни?', created_at: Date.parse('27.03.2016'))
    ]

    @new_question = Question.new
  end
end
