module Frontend::PostsHelper

  def categories_count_hash
     Post.unscoped.joins(:category).select("categories.name,count(posts.id)").group("categories.name").index_by(&:name)
  end

end
