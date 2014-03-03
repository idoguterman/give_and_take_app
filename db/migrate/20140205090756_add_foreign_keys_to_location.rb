class AddForeignKeysToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :user_id, :integer
    add_column :locations, :activity_id, :integer
  end
end
