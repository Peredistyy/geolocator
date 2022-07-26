# frozen_string_literal: true

require 'dry/container/stub'

class Container
  extend Dry::Container::Mixin

  namespace('service') do
    register('geolocation') do
      GeolocationService.new
    end

    register('geo_data_provider') do
      GeoDataProvider.new
    end

    namespace('provider') do
      register('ipstack') do
        Provider::Ipstack.new
      end
    end
  end
end
