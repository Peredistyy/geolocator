require 'rails_helper'

RSpec.describe RemoveGeoLocationHandler, type: :handler do
  let(:ip) { '31.129.66.251' }
  let(:command) { RemoveGeoLocationCommand.new(data: { ip: ip }) }

  describe '#call' do
    it 'success' do
      create(:geolocation, ip: ip)

      expect(Geolocation.find_by(ip: ip)).not_to eq(nil)

      described_class.new.call(command)

      expect(Geolocation.find_by(ip: ip)).to eq(nil)
    end

    it 'success (remove not exists record)' do
      described_class.new.call(command)
      expect(Geolocation.find_by(ip: ip)).to eq(nil)
    end
  end
end
