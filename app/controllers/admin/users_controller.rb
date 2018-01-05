class Admin::UsersController < Admin::BaseController
  before_action :require_super_admin!
  
   def index
     @users = User.all.paginate(:page => params[:page], :per_page => 20) 
   end

   def edit
     @user = User.find(params[:id])
   end

   def update
     @user = User.find(params[:id])

     if @user.update(user_params)
       redirect_to admin_users_path
     else
       render "edit"
     end
   end

   def bulk_update
     total = 0
     Array(params[:ids]).each do |user_id|
       user = User.find(user_id)
       user.destroy
       total += 1
     end

     flash[:alert] = "成功完成 #{total} 笔"
     redirect_to admin_users_path
   end
   
   protected

   def user_params
     params.require(:user).permit(:email,:username, :role)
   end
end
