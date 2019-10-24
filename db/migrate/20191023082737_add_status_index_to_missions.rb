class AddStatusIndexToMissions < ActiveRecord::Migration[6.0]
  def change
    add_index :missions, :status
  end
end
