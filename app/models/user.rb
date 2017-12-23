class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :groups
  has_many :posts
  has_many :comments #小组文章post的评论
  has_many :artile_comments  #官方文章official article的评论
end
