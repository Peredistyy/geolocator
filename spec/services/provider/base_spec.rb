# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Provider::Base do
  describe '#geo_data_by_ip' do
    it 'success' do
      expect { described_class.new.geo_data_by_ip('1.1.1.1') }.to(
        raise_error(
          NotImplementedError,
          "#{described_class.to_s} has not implemented method 'geo_data_by_ip'"
        )
      )
    end
  end
end
