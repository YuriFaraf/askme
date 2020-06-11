class Question < ApplicationRecord
  validates :text, length: { maximum: 255 }, presence: true
  validates :user, presence: true
end
