# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeoDataProvider do
  describe '#geo_data_by_ip' do
    let(:ip) { '31.129.66.251' }
    let(:response_body) { "{'test': 'success'}" }

    before do
      allow_any_instance_of(Provider::Ipstack).to receive(:geo_data_by_ip).with(ip).and_return(response_body)
    end

    it 'success' do
      expect(described_class.new.geo_data_by_ip(ip)).to eq(response_body)
    end
  end

  describe 'data_provider_name' do
    it 'success' do
      expect(described_class.new.data_provider_name).to eq(Figaro.env.provider_type)
    end
  end
end
