class GeoDataProvider
  def geo_data_by_ip(ip)
    provider.geo_data_by_ip(ip)
  end

  def data_provider_name
    Figaro.env.provider_type
  end

  private

  def provider
    Container[Figaro.env.provider_type]
  end
end