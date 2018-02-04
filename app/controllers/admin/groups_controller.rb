class Admin::GroupsController < Admin::BaseController
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]
  before_action :validate_search_key, only: [:search]

  def index
    @groups = Group.all.recent.paginate(:page => params[:page], :per_page => 20)
  end

  def edit
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      current_user.join!(@group)
      redirect_to admin_groups_path
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to admin_groups_path, notice:"更新成功！"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to admin_groups_path, alert: "删除成功！"
  end

  def search
    if @query_string.present?
      search_result = Group.ransack(@search_criteria).result(:distinct => true)
      @groups = search_result.paginate(:page => params[:page], :per_page => 20 )
    end
  end

  def bulk_update
    total = 0
    Array(params[:ids]).each do |group_id|
      group = Group.find(group_id)
      group.destroy
      total += 1
    end

    flash[:alert] = "成功完成 #{total} 笔"
    redirect_to admin_jobs_path
  end

  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end


  def search_criteria(query_string)
    { :title_cont => query_string }
  end

  private

  def find_group_and_check_permission
    @group = Group.find(params[:id])

    unless current_user.is_editor?
      redirect_to root_path, alert: "抱歉，您没有相应的权限！"
    end
  end

  def group_params
    params.require(:group).permit(:title, :logo, :remove_logo, :description, :status)
  end

end
