class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  
  has_many :registrations, dependent: :destroy
  has_many :channels, through: :registrations
  has_many :builds, dependent: :destroy
  has_many :results, dependent: :destroy
  
  has_one_attached :profile_picture
  
  def admin?
    role == "admin"
  end
  
  def registered_for?(event)
    (registrations.where(event: event.id).length > 0)
  end
  
  def registration_for(event)
    registrations.find_by(event: event.id)
  end
  
  def self.not_registered_for(event)
    users = Registration.where(event: event).collect { |r| r.user.id }
    where.not(id: users)
  end
  
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    unless user
       user = User.create(name: data['name'],
          email: data['email'],
          password: Devise.friendly_token[0,20]
       )
    end
    user
  end
end
