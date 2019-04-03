password = "12345678"
1.upto(5) do |i|
  name = Faker::Name.name
  User.create(
    name: name,
    email: "user-#{i}@gmail.com",
    password: password,
    password_confirmation: password
  )
end
