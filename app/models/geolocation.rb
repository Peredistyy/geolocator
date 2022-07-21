class Geolocation < ApplicationRecord
  validates :ip, :data_provider, presence: true
end
