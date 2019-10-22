class AddMissionColumnsToMissions < ActiveRecord::Migration[6.0]
  def change
    add_column :missions, :start_at, :datetime
    add_column :missions, :end_at, :datetime
    add_column :missions, :priority, :integer, default: 0
    add_column :missions, :status, :integer, default: 0
  end
end
