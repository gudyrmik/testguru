class AddTestRefToCategory < ActiveRecord::Migration[6.0]
  def change
    add_reference :categories, :test, foreign_key: true
  end
end
