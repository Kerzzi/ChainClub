class Admin::SitesController < Admin::BaseController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @site_nodes = SiteNode.all
    @sites = Site.all
  end  
  
  def show
    @site = Site.find(params[:id])
  end

  def edit
    @site = Site.find(params[:id])
  end  
  
  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    
    if @site.save
      redirect_to admin_sites_path
    else
      render :new
    end 
  end
  
  def update 
    @site = Site.find(params[:id])
      
    if @site.update(site_params)
      redirect_to admin_sites_path, notice:"更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy  
    @site = Site.find(params[:id])
    @site.destroy
    redirect_to admin_sites_path, alert: "删除成功！"
  end

  private
 
  def site_params
    params.require(:site).permit(:name, :url, :description, :site_node_id, :user_id)
  end   
end
