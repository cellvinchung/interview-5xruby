class AddUserToMissions < ActiveRecord::Migration[6.0]
  def change
    add_reference :missions, :user, foreign_key: true
  end
end
