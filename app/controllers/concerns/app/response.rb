module App::Response
  extend ActiveSupport::Concern

  protected

  def json_pagination(collection)
    {
      entries: collection.total_entries,
      pages: collection.total_pages,
      per_page: collection.per_page
    }.to_json
  end
end
