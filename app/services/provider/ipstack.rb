module Provider
  class Ipstack < Base
    URL = 'http://api.ipstack.com'

    def geo_data_by_ip(ip)
      response = connection.get('/' + ip) do |request|
        request.params = {access_key: Figaro.env.ipstack_api_key}
      end

      JSON.parse(response.body)
    end

    private

    def connection
      @connection ||=
        Faraday.new(url: URL) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
    end
  end
end