class SitesController < ApplicationController
  before_action :validate_search_key, only: [:search]
  
  def index
    @site_nodes = SiteNode.all
    @site = Site.all
  end
  
  def search
    if @query_string.present?
     
      search_result = Site.ransack(@search_criteria).result(:distinct => true)
      @sites = search_result.paginate(:page => params[:page], :per_page => 15 )
    end
  end


   protected

   # 取到params[:q]的内容并去掉非法的内容
   def validate_search_key
     @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
     @search_criteria = search_criteria(@query_string)
   end


   def search_criteria(query_string)
     { :name_cont => query_string }
   end
     
end
