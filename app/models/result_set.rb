class ResultSet < ApplicationRecord
  has_many :results
  belongs_to :event
  
  scope :includes_user, -> (user) { includes(:results).where(results: {user: user})}
end
