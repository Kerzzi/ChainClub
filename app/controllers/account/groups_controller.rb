class Account::GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.groups.recent.paginate(:page => params[:page], :per_page => 10)
    @participated_groups = current_user.participated_groups.recent.paginate(:page => params[:page], :per_page => 10)
  end
end
