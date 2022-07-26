class RemoveGeoLocationHandler
  def call(command)
    ip = command.data[:ip]

    Geolocation.find_by(ip: ip)&.destroy
  end
end