class Account::TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @topics = current_user.topics.recent.paginate(:page => params[:page], :per_page => 10)
  end
end
