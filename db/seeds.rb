require 'faker'
require 'open-uri'

Conversation.destroy_all
Message.destroy_all
User.destroy_all
Dog.destroy_all
Community.destroy_all


puts "Creating users..."

users = [] # Define an empty array to store created users
boroughs = %w[Hackney Croydon Camden Stratford Shoreditch Lambeth Newham Greenwich Lewisham Southwark Islington Westminster Hammersmith Fulham]

10.times do |i|
  user = User.create(
    name: Faker::Name.first_name,
    email: "user#{i}@user.com",
    password: '123456',
    location: boroughs.sample,
    age: rand(25..30),
    bio: Faker::Lorem.paragraph
  )
  file = URI.open('https://thispersondoesnotexist.com')
  user.photo.attach(io: file, filename: "user#{i}.png", content_type: 'image/png')
  users << user # Add the created user to the users array
end

puts "Users created!"
puts "Creating dogs..."

users.each_with_index do |user, user_index|
  unless user.dogs.exists? # Check if the user already has a dog associated
    dog = Dog.create!(
      name: Faker::Creature::Dog.name,
      age: rand(1..10),
      breed: Faker::Creature::Dog.breed,
      gender: Faker::Gender.binary_type,
      bio: Faker::Creature::Dog.meme_phrase,
      user_id: user.id
    )

    2.times do |photo_index|
      file = URI.open('https://img.freepik.com/free-photo/ai-generated-labrador-retriever-dog-picture_23-2150644908.jpg')
      dog.photos.attach(io: file, filename: "dog#{user_index + 1}_photo#{photo_index + 1}.png", content_type: 'image/png')
    end
  end
end

puts "Dogs created!"

puts "Creating communities..."

communities = []

10.times do |i|
  community = Community.create(
    name: Faker::Creature::Dog.breed + " Lovers",
    description: Faker::Lorem.paragraph
  )

  file = URI.open('https://placedog.net/640/480?random')
  community.photo.attach(io: file, filename: "community#{i}.png", content_type: 'image/png')
  communities << community
end
