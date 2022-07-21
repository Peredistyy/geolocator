FactoryBot.define do
  factory :geolocation do
    ip { Faker::Internet.ip_v4_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    country_name { Faker::Address.country }
    city { Faker::Address.city }
    zip { Faker::Address.zip }
    data_provider { 'Provider::Ipstack' }
  end
end