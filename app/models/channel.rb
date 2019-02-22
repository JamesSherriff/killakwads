class Channel < ApplicationRecord
  belongs_to :band
  has_many :registrations
  has_and_belongs_to_many :events
end
