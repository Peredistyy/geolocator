class AddGeoLocationHandler
  def call(command)
    ip = command.data[:ip]

    geo_data = data_provider.geo_data_by_ip(ip)

    geolocation = Geolocation.find_or_initialize_by(ip: ip)

    geolocation.latitude = geo_data['latitude']
    geolocation.longitude = geo_data['longitude']
    geolocation.country_name = geo_data['country_name']
    geolocation.city = geo_data['city']
    geolocation.zip = geo_data['zip']
    geolocation.raw = geo_data
    geolocation.data_provider = data_provider.data_provider_name

    geolocation.save!

    geolocation
  end

  private

  def data_provider
    @data_provider ||= GeoDataProvider.new
  end
end