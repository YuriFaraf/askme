module QuestionsHelper
  def text_with_hashtag_link(text)
    text.gsub(Hashtag::REGEXP) { |ht| link_to ht, hashtag_path(ht.delete('#').downcase) }.html_safe
  end
end
