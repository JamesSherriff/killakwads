class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :channel, optional: true
  belongs_to :event
  
  validate :not_already_registered
  
  scope :finished, -> {joins(:event).where("events.finish < ?", Time.now)}
  scope :upcoming, -> {joins(:event).where("events.start > ?", Time.now)}
  
  def not_already_registered
    if Registration.find_by(event: event, user: user) != nil
      errors.add(:user, "registered")
    end
  end
end
