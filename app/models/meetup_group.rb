class MeetupGroup < ApplicationRecord
  has_paper_trail
  belongs_to :user
  validates :title, presence: true
  validates :meetup_type, presence: true
  validates :time_limit, presence: true
  validates :activity_time, presence: true
  validates :city, presence: true
  validates :address, presence: true  
  validates :register, presence: true
  validates :introduce, presence: true  
  
  #定义高亮显示功能的helper方法

  def render_highlight_content(meetup_group,query_string)

    excerpt_cont = excerpt(meetup_group.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end
    
end
