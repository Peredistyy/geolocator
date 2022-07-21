require 'feature_helper'

feature 'Locator::Users', type: :api do
  let(:password) { 'testpass' }
  let(:user) { create(:user, password: password, password_confirmation: password) }

  describe 'auth' do
    it 'success' do
      page.driver.post(
        '/users/auth',
        email: user.email, password: password
      )

      expect(page.status_code).to eq(201)
      expect(json.keys).to eq(%w[id token])
    end

    it 'user not found' do
        page.driver.post(
          '/users/auth',
          email: 'test@test.com', password: 'test'
        )

        expect(page.status_code).to eq(404)
        expect(json['status_code']).to eq('not_found')
    end

    it 'not valid password' do
      page.driver.post(
        '/users/auth',
        email: user.email, password: 'test'
      )

      expect(page.status_code).to eq(404)
      expect(json['status_code']).to eq('not_valid_password')
    end
  end
end
