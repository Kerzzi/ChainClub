class MeetupGroupRelationship < ApplicationRecord
  belongs_to :meetup_group
  belongs_to :user  
end
