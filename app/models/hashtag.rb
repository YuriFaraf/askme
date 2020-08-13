class Hashtag < ApplicationRecord
  REGEXP_H = /\#[a-zA-Zа-яА-Я\_\-]+/u

  has_many :hashtag_questions, dependent: :destroy
  has_many :questions, through: :hashtag_questions

  scope :with_questions, -> do
    left_outer_joins(:hashtag_questions).
        where.not(hashtag_questions: {id: nil}).
        distinct.order(:created_at)
  end

  validates :text, presence: true, uniqueness: true
end
