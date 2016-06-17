module HomeHelper
  def category_count_hash category_ids
    Post.unscoped.joins(:category).select("categories.id as category_id, count(posts.id)").where(categories: { id: category_ids }).group("categories.id").index_by(&:category_id)
  end

  def post_count_hash post_ids  #TODO frontend
    Post.unscoped.joins(:replies).select("posts.id as post_id, count(replies.id)").where(posts: { id: post_ids}).group("posts.id").index_by(&:post_id)
  end
end
