require 'rails_helper'

RSpec.describe Geolocation, type: :model do
  describe '#validate' do
    it { should validate_presence_of(:ip) }
    it { should validate_presence_of(:data_provider) }
  end
end
