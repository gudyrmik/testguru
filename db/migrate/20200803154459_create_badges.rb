class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.string :rule_subject, null: false
      t.string :rule_objective, null: false

      t.timestamps
    end
  end
end
