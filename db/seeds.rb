# Create a main sample user.
User.create!(name: "Example User",
  email: "hainn@gmail.com",
  password: "111111",
  password_confirmation: "111111",
  admin: true,
  activated: true,
  activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
  email: email,
  password:
  password,
  password_confirmation: password,
  activated: true,
  activated_at: Time.zone.now)
end

user = User.find.first
30.times do
  content = Faker::Lorem.sentence
  user.microposts.create!(content: content)
end

users = User.all
user = users.first
following = users[2..20]
followers = users[3..15]
following.each{|followed| user.follow(followed)}
followers.each{|follower| follower.follow(user)}
