# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Provider::Ipstack do
  describe '#geo_data_by_ip' do
    let(:ip) { '31.129.66.251' }
    let(:access_key) { Figaro.env.ipstack_api_key }
    let(:response_body) { '{"test": "success"}' }

    before do
      stub_request(:get, "http://api.ipstack.com/#{ip}?access_key=#{access_key}")
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => "Faraday v#{Faraday::VERSION}"
          }
        )
        .to_return(
          status: 200,
          body: response_body,
          headers: {}
        )
    end

    it 'success' do
      expect(described_class.new.geo_data_by_ip(ip)).to eq({'test' => 'success'})
    end
  end
end
