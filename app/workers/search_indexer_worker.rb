class SearchIndexerWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3
  sidekiq_options queue: :search

  def perform(type, id)
    obj = case type
            when 'post'
              Post.find_by_id(id)
            when 'user'
              User.find_by_id(id)
            else
              nil
          end
    PostgresqlSearch.index_searchable(obj)
  end
end
