class Question < ApplicationRecord
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :text, length: { maximum: 255 }, presence: true

  after_commit :create_hashtags, on: [:create, :update]

  private

  def create_hashtags
    self.hashtags =
        "#{answer} #{text}".
            downcase.
            scan(Hashtag::REGEXP).
            uniq.
            map { |ht| Hashtag.find_or_create_by(text: ht.delete('#')) }
  end
end
