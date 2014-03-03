class AddIndexToActivity < ActiveRecord::Migration
  def change
    add_index :activities, :user_id
    add_index :activities, :location_id
    add_index :activities, :name
  end
end
