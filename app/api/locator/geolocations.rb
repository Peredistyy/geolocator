module Locator
  class Geolocations < Grape::API
    include Extension::Authenticate

    resource :geolocations do
      desc 'Get geolocation', headers: Geolocations::auth_headers
      params do
        requires :destination, type: String, desc: 'IP address or URL', documentation: { param_type: 'query' }
      end
      get serializer: GeolocationSerializer do
        authenticate!

        begin
          ip = IPSocket::getaddress(params[:destination])
        rescue SocketError
          error!('destination is not valid', 400)
        end

        Geolocation.find_by!(ip: ip)
      end
    end
  end
end