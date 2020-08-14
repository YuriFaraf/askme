class Hashtag < ApplicationRecord
  REGEXP = /\#[[:alpha:]\_\-]+/u

  has_many :hashtag_questions, dependent: :destroy
  has_many :questions, through: :hashtag_questions

  scope :with_questions, -> { where_exists(:hashtag_questions).order(:created_at) }

  validates :text, presence: true, uniqueness: true
end
