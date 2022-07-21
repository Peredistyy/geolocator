# API users
[
  {
    email: 'api@geolocator.com',
    password: 'CML83cnp'
  }
]
.reject { |item| User.find_by(email: item[:email]) }
.each do |item|
  user = User.new(
    :email                 => item[:email],
    :password              => item[:password],
    :password_confirmation => item[:password]
  )
  user.save!
end
