class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :channel
  belongs_to :event
  
  validate :not_already_registered
  
  def not_already_registered
    if Registration.find_by(event: event, user: user) != nil
      errors.add(:user, "registered")
    end
  end
end
