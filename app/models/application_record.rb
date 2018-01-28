class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # Scope #
  scope :recent, -> { order("created_at DESC")}
end
