class AddIndexesToLocation < ActiveRecord::Migration
  def change
    add_index :locations, :activity_id
    add_index :locations, :user_id
  end
end
