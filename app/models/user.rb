class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups
  has_many :group_relationships
  has_many :participated_groups, :through => :group_relationships, :source => :group  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy #小组文章post的评论
  has_many :official_articles, dependent: :destroy
  has_many :article_comments, dependent: :destroy  #官方文章official article的评论
  has_many :answers, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :projects
  has_many :meetup_groups, dependent: :destroy
  has_many :courses  
  has_many :meetup_comments, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :jobs
  
  has_many :course_comments, dependent: :destroy

  
  has_many :post_comments, dependent: :destroy
  
   
  action_store :like, :topic, counter_cache: true
  action_store :star, :topic, counter_cache: true, user_counter_cache: true
  action_store :follow, :topic
  action_store :like, :answers, counter_cache: true
  action_store :follow, :user, counter_cache: 'followers_count', user_counter_cache: 'following_count'
  
  has_paper_trail
  
  mount_uploader :avatar, UserAvatarUploader

  accepts_nested_attributes_for :profile

  ACCESSABLE_ATTRS = [:username, :email, :avatar, :summary, :current_password, :password, :password_confirmation]
  REWARD_FIELDS  = [:alipay, :wechat]

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
  
  def display_name
    if self.username.present?
      self.username
    else
      self.email.split("@").first
    end
  end
  
  def is_member_of?(group)
    participated_groups.include?(group)
  end  
  
  def join!(group)
    participated_groups << group
  end

  def quit!(group)
    participated_groups.delete(group)
  end

  # ---收藏官方文章功能三方关系代码块---
  has_many :official_article_relationships
  has_many :liked_official_articles, :through => :official_article_relationships, :source => :official_article
  
  def is_fan_of_official_article?(official_article)
    liked_official_articles.include?(official_article)
  end
  
  def like_official_article!(official_article)
    liked_official_articles << official_article
  end

  def unlike_official_article!(official_article)
    liked_official_articles.delete(official_article)
  end

  # ---收藏社区文章功能三方关系代码块---
  has_many :topic_relationships
  has_many :liked_topics, :through => :topic_relationships, :source => :topic
  
  def is_fan_of_topic?(topic)
    liked_topics.include?(topic)
  end
  
  def like_topic!(topic)
    liked_topics << topic
  end

  def unlike_topic!(topic)
    liked_topics.delete(topic)
  end
  
  # ---收藏活动功能三方关系代码块---

  has_many :meetup_group_relationships
  has_many :favorite_meetup_groups, :through => :meetup_group_relationships, :source => :meetup_group

  def is_favor_of_meetup_group?(meetup_group)
    favorite_meetup_groups.include?(meetup_group)
  end
  
  def favorite_meetup_group!(meetup_group)
    favorite_meetup_groups << meetup_group
  end

  def unfavorite_meetup_group!(meetup_group)
    favorite_meetup_groups.delete(meetup_group)
  end

  # ---收藏招聘信息功能三方关系代码块---

  has_many :job_relationships
  has_many :favorite_jobs, :through => :job_relationships, :source => :job
  
  def is_favor_of_job?(job)
    favorite_jobs.include?(job)
  end
  
  def favorite_job!(job)
    favorite_jobs << job
  end

  def unfavorite_job!(job)
    favorite_jobs.delete(job)
  end
    
  # ---收藏课程功能三方关系代码块---

  has_many :course_relationships
  has_many :favorite_courses, :through => :course_relationships, :source => :course

  def is_favor_of_course?(course)
    favorite_courses.include?(course)
  end
  
  def favorite_course!(course)
    favorite_courses << course
  end

  def unfavorite_course!(course)
    favorite_courses.delete(course)
  end

  # ---收藏项目功能三方关系代码块---
  
  has_many :project_relationships
  has_many :favorite_projects, :through => :project_relationships, :source => :project
  
  def is_favor_of_project?(project)
    favorite_projects.include?(project)
  end
  
  def favorite_project!(project)
    favorite_projects << project
  end

  def unfavorite_project!(project)
    favorite_projects.delete(project)
  end

  # ---收藏项目功能三方关系代码块---
  
  has_many :post_relationships
  has_many :favorite_posts, :through => :post_relationships, :source => :post
  
  def is_favor_of_post?(post)
    favorite_posts.include?(post)
  end
  
  def favorite_post!(post)
    favorite_posts << post
  end

  def unfavorite_post!(post)
    favorite_posts.delete(post)
  end
      
end
