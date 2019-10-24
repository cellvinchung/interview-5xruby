class AddMissionCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :missions_count, :integer, default: 0
    User.pluck(:id).each do |i|
      User.reset_counters(i, :missions) 
    end
  end
end
