class Account::MeetupGroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @meetup_groups = current_user.meetup_groups.recent.paginate(:page => params[:page], :per_page => 10)
  end
end
