class SiteNodesController < ApplicationController
  def show
    @site_node = SiteNode.find(params[:id])
    @sites = @site_node.sites
  end
end
