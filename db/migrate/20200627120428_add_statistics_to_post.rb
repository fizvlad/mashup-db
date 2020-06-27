class AddStatisticsToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :likes, :integer, default: 0
    add_column :posts, :reposts, :integer, default: 0
    add_column :posts, :views, :integer, default: 0
    add_column :posts, :comments, :integer, default: 0
  end
end
