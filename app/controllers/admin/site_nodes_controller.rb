class Admin::SiteNodesController < Admin::BaseController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @site_nodes = SiteNode.all
  end  

  def edit
    @site_node = SiteNode.find(params[:id])
  end  
  
  def new
    @site_node = SiteNode.new
  end

  def create
    @site_node = SiteNode.new(site_node_params)
    
    if @site_node.save
      redirect_to admin_site_nodes_path
    else
      render :new
    end 
  end
  
  def update 
    @site_node = SiteNode.find(params[:id])
      
    if @site_node.update(site_node_params)
      redirect_to admin_site_nodes_path, notice:"更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy  
    @site_node = SiteNode.find(params[:id])
    @site_node.destroy
    redirect_to admin_site_nodes_path, alert: "删除成功！"
  end

  private
 
  def site_node_params
    params.require(:site_node).permit(:name, :sort)
  end 
end
