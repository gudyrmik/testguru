module QuestionsHelper
  
  def question_form_header(question)
    if question.persisted?
      "Edit question #{question.body}"
    else
      'Add new question' 
    end
  end

end
