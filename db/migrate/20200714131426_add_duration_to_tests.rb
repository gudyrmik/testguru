class AddDurationToTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tests, :duration, :integer, default: 3600
  end
end
