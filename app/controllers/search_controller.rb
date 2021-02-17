class SearchController < ApplicationController
  before_action :validate_search_key

  def index
    if @query_string.present?
      @search = Topic.search(@search_criteria).result(:distinct => true)  
    end
  end
  
  protected
  
  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { :title_or_content_cont => query_string }
  end

end