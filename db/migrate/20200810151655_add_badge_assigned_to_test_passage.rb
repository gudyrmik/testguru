class AddBadgeAssignedToTestPassage < ActiveRecord::Migration[6.0]
  def change
    add_column :test_passages, :badge_assigned, :string, default: nil
  end
end
