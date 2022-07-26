require 'feature_helper'

feature 'Locator::Tasks', type: :api do
  let(:user) { create(:user) }
  let(:token) { create(:token, user: user).token }

  describe 'create' do
    let(:response_body) do
      '{"ip": "31.129.66.251", "type": "ipv4", "continent_code": "EU", "continent_name": "Europe", "country_code": "UA", "country_name": "Ukraine", "region_code": "12", "region_name": "Dnipropetrovsk", "city": "Kamyanske", "zip": "51933", "latitude": 48.51129913330078, "longitude": 34.60210037231445, "location": {"geoname_id": 709932, "capital": "Kyiv", "languages": [{"code": "uk", "name": "Ukrainian", "native": "\u0423\u043a\u0440\u0430\u0457\u043d\u0441\u044c\u043a\u0430"}], "country_flag": "https://assets.ipstack.com/flags/ua.svg", "country_flag_emoji": "\ud83c\uddfa\ud83c\udde6", "country_flag_emoji_unicode": "U+1F1FA U+1F1E6", "calling_code": "380", "is_eu": false}}'
    end

    describe 'with ip' do
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
        page.driver.post(
          '/tasks',
          destination: '31.129.66.251', action: 'add', token: token
        )

        expect(page.status_code).to eq(201)
        expect(json).to eq({'success' => true})
      end
    end

    describe 'by domain (ipstack.com)' do
      before do
        stub_request(
          :get,
          "http://api.ipstack.com/172.67.73.233?access_key=d9a81c856874376837722ff0df0aa307"
        ).with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v2.3.0'
          }
        ).to_return(status: 200, body: response_body, headers: {})
      end

      it 'success' do
        allow(IPSocket).to receive(:getaddress).with('ipstack.com').and_return('172.67.73.233')

        page.driver.post(
          '/tasks',
          destination: 'ipstack.com', action: 'add', token: token
        )

        expect(page.status_code).to eq(201)
        expect(json).to eq({'success' => true})
      end
    end

    it 'success by wrong domain' do
      page.driver.post(
        '/tasks',
        destination: 'http://ipstack.com/', action: 'add', token: token
      )

      expect(page.status_code).to eq(400)
      expect(json).to eq({'error' => 'destination is not valid'})
    end

    it 'unauthorized' do
      page.driver.post(
        '/tasks',
        destination: '31.129.66.251', action: 'add', token: 'test'
      )

      expect(page.status_code).to eq(401)
      expect(json).to eq({'error' => 'Unauthorized'})
    end
  end
end
