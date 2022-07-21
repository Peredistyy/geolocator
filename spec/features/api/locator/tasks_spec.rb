require 'feature_helper'

feature 'Locator::Tasks', type: :api do
  let(:user) { create(:user) }
  let(:token) { create(:token, user: user).token }

  describe 'create' do
    it 'success' do
      page.driver.post(
        '/tasks',
        destination: '31.129.66.251', action: 'add', token: token
      )

      expect(page.status_code).to eq(201)
      expect(json).to eq({'success' => true})
    end

    it 'success by domain (ipstack.com)' do
      page.driver.post(
        '/tasks',
        destination: 'ipstack.com', action: 'add', token: token
      )

      expect(page.status_code).to eq(201)
      expect(json).to eq({'success' => true})
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
