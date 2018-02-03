class MeetupCommentsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @meetup_group = MeetupGroup.find(params[:meetup_group_id])
    @meetup_comment = MeetupComment.new
  end

  def create
    @meetup_group  = MeetupGroup.find(params[:meetup_group_id])
    @meetup_comment = MeetupComment.new(meetup_comment_params)
    @meetup_comment.meetup_group = @meetup_group
    @meetup_comment.user = current_user

    if @meetup_comment.save
      redirect_to meetup_group_path(@meetup_group)
    else
      render :new
    end
  end

  def destroy
    @meetup_group = MeetupGroup.find(params[:meetup_group_id])
    @meetup_comment = MeetupComment.find(params[:id])
    @meetup_comment.destroy
    redirect_to meetup_group_path(@meetup_group), alert: "删除成功！"
  end

  private

  def meetup_comment_params
    params.require(:meetup_comment).permit(:content)
  end  
end
