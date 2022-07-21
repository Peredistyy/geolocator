# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeolocationService do
  let(:ip) { '31.129.66.251' }
  let(:country_name) { 'Ukraine' }
  let(:response_body) do
    '{"ip": "31.129.66.251", "type": "ipv4", "continent_code": "EU", "continent_name": "Europe", "country_code": "UA", "country_name": "' + country_name + '", "region_code": "12", "region_name": "Dnipropetrovsk", "city": "Kamyanske", "zip": "51933", "latitude": 48.51129913330078, "longitude": 34.60210037231445, "location": {"geoname_id": 709932, "capital": "Kyiv", "languages": [{"code": "uk", "name": "Ukrainian", "native": "\u0423\u043a\u0440\u0430\u0457\u043d\u0441\u044c\u043a\u0430"}], "country_flag": "https://assets.ipstack.com/flags/ua.svg", "country_flag_emoji": "\ud83c\uddfa\ud83c\udde6", "country_flag_emoji_unicode": "U+1F1FA U+1F1E6", "calling_code": "380", "is_eu": false}}'
  end

  describe '#add' do
    before do
      stub_request(
        :get,
        "http://api.ipstack.com/31.129.66.251?access_key=d9a81c856874376837722ff0df0aa307"
      ).with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.3.0'
        }
      ).to_return(status: 200, body: response_body, headers: {})
    end

    it 'success' do
      expect(Geolocation.find_by(ip: ip)).to eq(nil)

      described_class.new.add(ip)

      expect(Geolocation.find_by(ip: ip).country_name).to eq(country_name)
    end

    it 'success (update exists record)' do
      create(:geolocation, ip: ip)

      expect(Geolocation.find_by(ip: ip).country_name).not_to eq(country_name)

      described_class.new.add(ip)

      expect(Geolocation.find_by(ip: ip).country_name).to eq(country_name)
    end
  end

  describe '#remove' do
    it 'success' do
      create(:geolocation, ip: ip)

      expect(Geolocation.find_by(ip: ip)).not_to eq(nil)

      described_class.new.remove(ip)

      expect(Geolocation.find_by(ip: ip)).to eq(nil)
    end

    it 'success (remove not exists record)' do
      described_class.new.remove(ip)
      expect(Geolocation.find_by(ip: ip)).to eq(nil)
    end
  end
end
