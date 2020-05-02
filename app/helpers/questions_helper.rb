module QuestionsHelper
  def question_form_header(question, form_type)
    case form_type
    when 'create'
      return 'Add new question'
    when 'edit'
      return "Edit question #{question.body}"
    end
  end
end
