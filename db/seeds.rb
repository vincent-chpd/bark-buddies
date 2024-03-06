require 'faker'
require "open-uri"

User.destroy_all
Dog.destroy_all

puts "Creating users..."

10.times do
  file = URI.open('https://thispersondoesnotexist.com')
  user = User.new(
    name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: '123456',
    location: Faker::Address.city,
    age: rand(25..30),
    bio: Faker::Lorem.paragraph
  )
  user.photo.attach(io: file, filename: 'dogowner.jpg', content_type: 'image/jpg')
  user.save!
  file.close
end


puts "Users created!"
puts "Creating dogs..."

10.times do Dog.create!(
  name: Faker::Creature::Dog.name,
  age: rand(1..10),
  breed: Faker::Creature::Dog.breed,
  gender: Faker::Gender.binary_type,
  bio: Faker::Creature::Dog.meme_phrase,
  user_id: User.all.sample.id
)
end

puts "Dogs created!"
