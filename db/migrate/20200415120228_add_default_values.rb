class AddDefaultValues < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:tests, :level, from: 5, to: 0)
    change_column_default(:answers, :correct, from: true, to: false)
  end
end
