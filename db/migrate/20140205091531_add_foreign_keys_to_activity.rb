class AddForeignKeysToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :user_id, :integer
    add_column :activities, :location_id, :integer
  end
end
