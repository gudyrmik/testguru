class AddTypeRefToBadges < ActiveRecord::Migration[6.0]
  def change
    add_reference :badges, :badge_type, null: false, foreign_key: true
  end
end
