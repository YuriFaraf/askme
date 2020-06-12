module UsersHelper
  def answered_questions(questions)
    num = 0
    questions.each do |question|
      num += 1 if question.answer.present?
    end
    num
  end
end
