class Account::PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = current_user.posts.recent.paginate(:page => params[:page], :per_page => 10)
    @favorite_posts = current_user.favorite_posts.recent.paginate(:page => params[:page], :per_page => 10)
  end
end
