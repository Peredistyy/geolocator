require 'feature_helper'

feature 'Locator::Geolocations', type: :api do
  let(:user) { create(:user) }
  let(:token) { create(:token, user: user).token }
  let(:ip) { '31.129.66.251' }
  let(:geolocation) { create(:geolocation, ip: ip) }

  describe 'get' do
    let(:expected_data) do
      {
        "city" => geolocation.city,
        "country_name" => geolocation.country_name,
        "id" => geolocation.id,
        "ip" => geolocation.ip,
        "latitude" => geolocation.latitude,
        "longitude" => geolocation.longitude,
        "zip" => geolocation.zip
      }
    end

    it 'success' do
      geolocation

      page.driver.get(
        '/geolocations',
        destination: ip, token: token
      )

      expect(page.status_code).to eq(200)
      expect(json).to eq(expected_data)
    end

    it 'success by wrong domain' do
      page.driver.get(
        '/geolocations',
        destination: 'http://ipstack.com/', token: token
      )

      expect(page.status_code).to eq(400)
      expect(json).to eq({'error' => 'destination is not valid'})
    end

    it 'unauthorized' do
      page.driver.get(
        '/geolocations',
        destination: '31.129.66.251', token: 'test'
      )

      expect(page.status_code).to eq(401)
      expect(json).to eq({'error' => 'Unauthorized'})
    end
  end
end
