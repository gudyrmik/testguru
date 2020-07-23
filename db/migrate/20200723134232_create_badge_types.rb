class CreateBadgeTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :badge_types do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
