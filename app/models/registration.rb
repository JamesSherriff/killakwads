class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :channel, optional: true
  belongs_to :event
  
  validate :not_already_registered
  
  scope :finished, -> {joins(:event).where("events.finish < ?", Time.now)}
  scope :upcoming, -> {joins(:event).where("events.finish > ?", Time.now)}
  
  def not_already_registered
    reg = Registration.find_by(event: event, user: user)
    if reg != self && reg != nil
      errors.add(:user, "registered")
    end
  end
  
  def clashing
    event.registrations.where(channel: channel).where("id != ?", id)
  end
end
