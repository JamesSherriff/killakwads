class Event < ApplicationRecord
  has_and_belongs_to_many :channels
  has_many :registrations, dependent: :destroy
  has_many :result_sets, dependent: :destroy
  
  has_one_attached :image
  has_one_attached :pilot_brief
  
  belongs_to :event_series, optional: true
  
  scope :registration_open, -> {where("registration_start < ? AND registration_end > ?", Time.now, Time.now)}
  
  def registration_open?
    (registration_start < Time.now && registration_end > Time.now) && (!registrations_full? || pilot_limit == 0)
  end
  
  def registrations_full?
    if pilot_limit > 0
      registrations.length == pilot_limit
    else
      false
    end
  end
  
  def running? 
    started? && !finished?
  end
  
  def started? 
    (start < Time.now)
  end
  
  def finished?
    (finish < Time.now)
  end
end
