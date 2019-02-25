class Event < ApplicationRecord
  has_and_belongs_to_many :channels
  has_many :registrations
  
  has_one_attached :image
  has_one_attached :pilot_brief
  
  scope :registration_open, -> {where("registration_start < ? AND registration_end > ?", Time.now, Time.now)}
  
  def registration_open?
    (registration_start < Time.now && registration_end > Time.now)
  end
  
  def finished
    finish < Time.now
  end
end
