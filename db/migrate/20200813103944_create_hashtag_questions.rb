class CreateHashtagQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :hashtag_questions do |t|
      t.belongs_to :hashtag
      t.belongs_to :question

      t.timestamps
    end
  end
end
