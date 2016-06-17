class SearchController < HomeController

  def index
    @result = Search.new(params[:q]).query_results.page(params[:page]).per(15)
  end
end
