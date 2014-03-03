class RemoveColumnsFromImage < ActiveRecord::Migration
  def change
    remove_column :images, :url, :string
    remove_column :images, :url_big, :string
    remove_column :images, :url_small, :string
    remove_column :images, :pid, :string
  end
end
