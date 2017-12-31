class Admin::BaseController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  
  layout 'admin'

  protected
  
  def require_editor!
    unless current_user.is_editor?
      flash[:alert] = "您的权限不足"
      redirect_to root_path
    end
  end
  
  def require_admin!
    unless current_user.is_admin?
      flash[:alert] = "您的权限不足"
      redirect_to root_path
    end
  end
  
  def require_super_admin!
    unless current_user.is_super_admin?
      flash[:alert] = "您的权限不足"
      redirect_to root_path
    end
  end
    
end
