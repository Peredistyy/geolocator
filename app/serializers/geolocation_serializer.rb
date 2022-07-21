class GeolocationSerializer < ActiveModel::Serializer
  attributes :id, :ip, :latitude, :longitude, :country_name, :city, :zip
end