module Admin::HomeHelper

  def category_count_hash category_ids
    Post.unscoped.joins(:category).select("categories.id as category_id, count(posts.id)").where(:categories => { :id => category_ids }).group("categories.id").index_by(&:category_id)
  end
end
