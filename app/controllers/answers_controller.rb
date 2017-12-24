class AnswersController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :find_topic_and_check_permission, only: [:edit, :update, :destroy]

  def new
    @topic = Topic.find(params[:topic_id])
    @answer = Answer.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @answer = Answer.new(answer_params)
    @answer.topic = @topic
    @answer.user = current_user

    if @answer.save
      redirect_to topic_path(@topic)
    else
      render :new
    end
  end

  def edit 
  end
  
  def update  
    if @answer.update(answer_params)
      redirect_to topic_path(@topic), notice:"更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy  
    @answer.destroy
    redirect_to topic_path(@topic), alert: "删除成功！"
  end
  
  private

  def find_topic_and_check_permission
    @topic = Topic.find(params[:topic_id])
    @answer = Answer.find(params[:id])

    if current_user != @answer.user
      redirect_to topic_path(@topic), alert: "抱歉，您没有相应的权限！"
    end
  end
  
  def answer_params
    params.require(:answer).permit(:content)
  end
end
