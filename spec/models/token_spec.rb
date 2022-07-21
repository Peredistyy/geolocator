require 'rails_helper'

RSpec.describe Token, type: :model do
  describe 'active record associations' do
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
  end

  describe '#associations' do
    it { is_expected.to belong_to(:user).required }
  end

  describe 'set_default_token' do
    let(:user) { create(:user) }

    it 'success' do
      token = Token.new(user: user)
      token.save!

      expect(token.token).not_to eq('')
    end
  end
end
