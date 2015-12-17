class AddImpressionsCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :impressions_count, :integer
  end
end
