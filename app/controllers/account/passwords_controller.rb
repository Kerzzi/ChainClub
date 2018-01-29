class Account::PasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
  end

# 重置密码目前涉及setting controller，后期改掉

end
