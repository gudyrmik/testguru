class AddAnswersCorrectDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:answers, :correct, false)
    change_column_default(:answers, :correct, false)
  end
end
