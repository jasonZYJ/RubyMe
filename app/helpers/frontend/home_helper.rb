module Frontend::HomeHelper

  def post_count_hash post_ids
      Post.unscoped.joins(:replies).select("posts.id as post_id, count(replies.id)").where(:posts => { :id => post_ids}).group("posts.id").index_by(&:post_id)
  end

end
