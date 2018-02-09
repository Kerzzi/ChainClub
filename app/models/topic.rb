class Topic < ApplicationRecord
  has_paper_trail

  validates :user_id, :title, :content, :node_id, presence: true
  has_many :answers, dependent: :destroy
  belongs_to :user
  belongs_to :node, :optional => true

  has_many :topic_relationships
  has_many :fans, through: :topic_relationships, source: :user


  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS

  # Scope #
  scope :published, -> { where(:status => "public")}
  scope :random5, -> { limit(5).order("RANDOM()") }
  scope :last_actived,       -> { order(last_active_mark: :desc) }
  scope :recent, -> { order("created_at DESC")}

  scope :high_replies,       -> { order(answers_count: :desc).order(id: :desc) }
  scope :no_reply,           -> { where(answers_count: 0) }


  scope :without_users,      ->(ids) { exclude_column_ids("user_id", ids) }
  scope :exclude_column_ids, ->(column, ids) { ids.empty? ? all : where.not(column => ids) }


  # 相似文字这个还没有搞明白
  def related_topics(size = 5)
    opts = {
      query: {
        more_like_this: {
          fields: [:title, :content],
          like: [
            {
              _index: self.class.index_name,
              _type: self.class.document_type,
              _id: id
            }
          ],
          min_term_freq: 2,
          min_doc_freq: 5
        }
      },
      size: size
    }
    self.class.__elasticsearch__.search(opts).records.to_a
  end


  before_create :init_last_active_mark_on_create
  def init_last_active_mark_on_create
    self.last_active_mark = Time.now.to_i
  end


  def update_last_answer(answer, opts = {})
    # replied_at 用于最新回复的排序，如果帖着创建时间在一个月以前，就不再往前面顶了
    return false if answer.blank? && !opts[:force]

    self.last_active_mark = Time.now.to_i if created_at > 1.month.ago
    self.answered_at = answer.try(:created_at)
    self.answers_count = answers.without_system.count
    self.last_reply_id = answer.try(:id)
    self.last_reply_user_id = answer.try(:user_id)
    self.last_reply_username = answer.try(:username)

    save
  end

  # 删除并记录删除人
  def destroy_by(user)
    return false if user.blank?
    update_attribute(:who_deleted, user.email)
    destroy
  end

  # 所有的回复编号
  def answer_ids
    Rails.cache.fetch([self, "answer_ids"]) do
      self.answers.order("id asc").pluck(:id)
    end
  end


  def floor_of_answer(answer)
    answer_index = answer_ids.index(answer.id)
    answer_index + 1
  end

  # 给关注者发通知,尚未完成

end
