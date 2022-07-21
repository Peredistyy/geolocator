class Token < ApplicationRecord
  belongs_to :user

  validates :token, presence: true

  before_validation :set_default_token

  private

  def set_default_token
    self.token = Digest::MD5.hexdigest(Faker::String.random)
  end
end
