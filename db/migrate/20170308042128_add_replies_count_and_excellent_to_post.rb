class AddRepliesCountAndExcellentToPost < ActiveRecord::Migration
  def change
    add_column :posts, :replies_count, :integer, default: 0
    add_column :posts, :excellent, :integer, default: 0
    rename_column :posts, :likes, :likes_count
  end
end
