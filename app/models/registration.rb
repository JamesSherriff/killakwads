class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :channel
  belongs_to :event
end
