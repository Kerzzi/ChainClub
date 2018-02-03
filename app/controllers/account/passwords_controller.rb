class Account::PasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def index
  end

  private

  def find_user
    @user = current_user
  end

  #重置密码目前涉及setting controller，后期改掉

end
