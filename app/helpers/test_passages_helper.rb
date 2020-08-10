module TestPassagesHelper
  def test_passage_conclusion(test_passage)
    if test_passage.completed? && test_passage.successful?
      'passed'
    else
      'failed'
    end
  end
end
