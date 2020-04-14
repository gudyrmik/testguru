class AddQuestionRefToTest < ActiveRecord::Migration[6.0]
  def change
    add_reference :tests, :question, foreign_key: true
  end
end
