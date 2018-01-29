class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end

  def update
    case params[:by]
    when "password"
      update_password
    end
  end


  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(*User::ACCESSABLE_ATTRS)
  end


  def update_password
    if @user.update_with_password(user_params)
      redirect_to new_session_path(:user), notice: "密码更新成功，现在你需要重新登陆。"
    else
      redirect_to account_passwords_path
    end
  end
end
