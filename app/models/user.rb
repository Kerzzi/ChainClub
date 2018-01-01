class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups
  has_many :posts
  has_many :comments #小组文章post的评论
  has_many :official_articles
  has_many :article_comments  #官方文章official article的评论
  has_many :answers
  has_many :topics
  has_many :meetup_groups
  has_one :profile
  has_many :jobs
  has_many :courses
  has_many :projects

  accepts_nested_attributes_for :profile

  ROLES = ["super_admin","admin", "editor"]

  def is_super_admin?
    self.role == "super_admin"
  end

  def is_admin?
    ["super_admin", "admin"].include?(self.role) # 如果是 super_admin 的话，当然也有 admin 的权限
  end

  def is_editor?
    ["super_admin","admin", "editor"].include?(self.role)
  end

end
