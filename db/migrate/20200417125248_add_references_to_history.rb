class AddReferencesToHistory < ActiveRecord::Migration[6.0]
  def change
    add_reference :histories, :user, foreign_key: true
    add_reference :histories, :test, foreign_key: true
  end
end
