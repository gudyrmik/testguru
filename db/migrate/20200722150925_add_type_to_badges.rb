class AddTypeToBadges < ActiveRecord::Migration[6.0]
  def change
    add_column :badges, :type, :string, null: false
  end
end
