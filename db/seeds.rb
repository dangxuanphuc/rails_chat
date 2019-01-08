password = "12345678"
1.upto(5) do |i|
  User.create(
    email: "user-#{i}@gmail.com",
    password: password,
    password_confirmation: password
  )
end
