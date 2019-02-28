class ResultSet < ApplicationRecord
  has_many :results
  belongs_to :event
end
