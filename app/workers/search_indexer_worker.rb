class SearchIndexerWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3
  sidekiq_options queue: :search

  def perform(type, id)
    obj = (%w(post blog user).inject({}) { |h, x| h[x] = x.classify; h }).fetch(type, nil).try(:safe_constantize).try(:find_by_id, id)
    PostgresqlSearch.index_searchable(obj) if obj.present?
  end
end
