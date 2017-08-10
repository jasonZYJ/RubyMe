module HomeHelper
  def category_count_hash category_ids
    count_hash(:category, "categories.id as category_id, count(posts.id)", { categories: { id: category_ids } }, "categories.id", :category_id)
  end

  def post_count_hash post_ids
    count_hash(:replies, "posts.id as post_id, count(replies.id)", { posts: { id: post_ids } }, "posts.id", :post_id)
  end

  def count_hash table, select_cols, condition, group_col, index_col
    Post.unscoped.joins(table).select(select_cols).where(condition).group(group_col).index_by(&index_col)
  end
end