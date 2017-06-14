class Search
  def initialize(term, opts=nil)
    if term.present?
      @term = Search.prepare_data(term.to_s)
      @original_term = PG::Connection.escape_string(@term)

      @opts = opts || {}
      @results = []
    end
  end

  def query_results
    PostgresqlSearch.where("search_data @@ #{ts_query}")
        .order("#{ts_query} DESC")
        .order("TS_RANK_CD(search_data, #{ts_query}) DESC")

  end

  def self.prepare_data(document)
    document = document.squish

    unless defined? RMMSeg
      require 'rmmseg'
      RMMSeg::Dictionary.load_dictionaries
    end

    algo = RMMSeg::Algorithm.new(document)
    data = ""
    while (token = algo.next_token)
      data << token.text << " "
    end
    data.force_encoding("UTF-8")
    data
  end

  def ts_query
    @ts_query ||= begin
      all_terms = @term.gsub(/[:()&!'"]/,'').split
      query = PostgresqlSearch.sanitize(all_terms.map {|t| "#{PG::Connection.escape_string(t)}:*"}.join(" & "))
      "TO_TSQUERY('simple', #{query})"
    end
  end
end
