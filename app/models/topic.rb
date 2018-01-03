class Topic < ApplicationRecord
  has_paper_trail
  
  validates :user_id, :title, :content, :node_id, presence: true
  has_many :answers, dependent: :destroy
  belongs_to :user
  belongs_to :node, :optional => true

  scope :last_actived,       -> { order(last_active_mark: :desc) }
  scope :high_likes,         -> { order(likes_count: :desc).order(id: :desc) }
  scope :high_replies,       -> { order(replies_count: :desc).order(id: :desc) }
  scope :no_reply,           -> { where(replies_count: 0) }
  scope :popular,            -> { where("likes_count > 5") }
  scope :excellent,          -> { where("excellent >= 1") }
  scope :without_hide_nodes, -> { exclude_column_ids("node_id", Topic.topic_index_hide_node_ids) }

  scope :without_node_ids,   ->(ids) { exclude_column_ids("node_id", ids) }
  scope :without_users,      ->(ids) { exclude_column_ids("user_id", ids) }
  scope :exclude_column_ids, ->(column, ids) { ids.empty? ? all : where.not(column => ids) }  
  
  scope :without_nodes, lambda { |node_ids|
    ids = node_ids + Topic.topic_index_hide_node_ids
    ids.uniq!
    exclude_column_ids("node_id", ids)
  }
  
  # 删除并记录删除人
  def destroy_by(user)
    return false if user.blank?
    update_attribute(:who_deleted, user.email)
    destroy
  end
  
  def self.fields_for_list
    columns = %w(content who_deleted)
    select(column_names - columns.map(&:to_s))
  end  
  
  def self.topic_index_hide_node_ids
    Setting.node_ids_hide_in_topics_index.to_s.split(",").collect(&:to_i)
  end
  
  before_create :init_last_active_mark_on_create
  def init_last_active_mark_on_create
    self.last_active_mark = Time.now.to_i
  end  
  
  def excellent?
    excellent >= 1
  end    

end
