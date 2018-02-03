class Admin::MeetupGroupsController < Admin::BaseController
  before_action :find_meetup_group_and_check_permission, only: [:edit, :update, :destroy]
  before_action :validate_search_key, only: [:search]

  def index
    @meetup_groups = case params[:order]
                      when 'by_offline'
                        MeetupGroup.all.offline_meetup.paginate(:page => params[:page], :per_page => 10)
                      when 'by_online'
                        MeetupGroup.all.online_meetup.paginate(:page => params[:page], :per_page => 10)
                      else
                        MeetupGroup.all.paginate(:page => params[:page], :per_page => 10)
                      end

  end

  def new
    @meetup_group = MeetupGroup.new
  end

  def create
    @meetup_group = MeetupGroup.new(meetup_group_params)
    @meetup_group.user = current_user

    if @meetup_group.save
      redirect_to admin_meetup_groups_path
    else
      render :new
    end
  end

  def show
    @meetup_group = MeetupGroup.find(params[:id])
  end

  def edit
  end

  def update
    if @meetup_group.update(meetup_group_params)
      redirect_to admin_meetup_groups_path, notice:"更新成功！"
    else
      render :edit
    end
  end

  def destroy
    @meetup_group.destroy
    redirect_to admin_meetup_groups_path, alert: "删除成功！"
  end

   def search
     if @query_string.present?
       search_result = MeetupGroup.ransack(@search_criteria).result(:distinct => true)
       @meetup_groups = search_result.paginate(:page => params[:page], :per_page => 15 )
     end
   end

   def bulk_update
     total = 0
     Array(params[:ids]).each do |meetup_group_id|
       meetup_group = MeetupGroup.find(meetup_group_id)
       meetup_group.destroy
       total += 1
     end

     flash[:alert] = "成功完成 #{total} 笔"
     redirect_to admin_meetup_groups_path
   end

   protected

   # 取到params[:q]的内容并去掉非法的内容
   def validate_search_key
     @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
     @search_criteria = search_criteria(@query_string)
   end


   def search_criteria(query_string)
     { :title_cont => query_string }
   end

  private
  def find_meetup_group_and_check_permission
    @meetup_group = MeetupGroup.find(params[:id])
  end

  def meetup_group_params
    params.require(:meetup_group).permit(:title, :logo, :remove_logo, :status, :meetup_type, :time_limit, :activity_time, :city, :address, :register, :introduce, :user_id)
  end

end
