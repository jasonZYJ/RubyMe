module PostsHelper

  def sources_collection
    Post::SOURCES.map.with_index { |key, index| [key, index] }
  end

  # def categories_count_hash TODO frontend
  #   Post.unscoped.joins(:category).select("categories.name,count(posts.id)").group("categories.name").index_by(&:name)
  # end

end
