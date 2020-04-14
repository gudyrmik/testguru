class AddAnswerRefToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_reference :questions, :answer, foreign_key: true
  end
end
