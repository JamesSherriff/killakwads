class Band < ApplicationRecord
  has_many :channels, :dependent => :destroy
end
