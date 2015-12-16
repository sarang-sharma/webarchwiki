class AddAdminIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :admin_id, :integer
    add_index :articles, :admin_id
  end
end
