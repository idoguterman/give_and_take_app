class AddUrlsToImage < ActiveRecord::Migration
  def change
    add_column :images, :url_big, :string
    add_column :images, :url_small, :string
    add_column :images, :pid, :string
  end
end
