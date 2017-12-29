class SitesController < ApplicationController
  def index
    @site_nodes = SiteNode.all
    @site = Site.all
  end
end
