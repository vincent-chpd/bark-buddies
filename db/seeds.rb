require 'faker'
require 'open-uri'

Community.destroy_all
Conversation.destroy_all
Message.destroy_all
Event.destroy_all
User.destroy_all
Dog.destroy_all


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
      file = URI.open('https://placedog.net/640/480?random')
      dog.photos.attach(io: file, filename: "dog#{user_index + 1}_photo#{photo_index + 1}.png", content_type: 'image/png')
    end
  end
end

puts "Dogs created!"

puts "Creating events!"
events = [
  {
    title: "Yappy Hour: A Tail-Wagging Extravaganza!",
    description: "Unleash the joy and let the fur fly at our Happy Hour for Hounds!",
    # turn this into a date.
    date: "20 April 2024",
    location: 'Reading',
    img: "https://saltydogpaddle.org/wp-content/uploads/2019/11/yappyhourbeer-1024x585.jpg"
  },
  {
    title: "Paws in Motion: Walkathon for Dogs!",
    description: "Get ready to put your best paw forward at Paws in Motion, the ultimate event for dogs!",
    date: "29 April 2024",
    location: 'Surrey',
    img: "https://www.rauanimalhospital.com/sites/default/files/summertime-events-for-dogs-blog-header.jpg"
  },
  {
    title: "Kindness Day: Spreading Love and Compassion to All",
    description: "Join us for a heartwarming celebration of kindness, where small acts of compassion make differences!",
    date: "1 May 2024",
    location: 'Earlsfield',
    img: "https://k9nation.dog/k9nation/wp-content/uploads/2022/03/Dog-Events-Feature.jpeg"
  },

  {
    title: "Glits and Grace: A Spectacular Pageant Show",
    description: "Step into the spotlight and experience the magic of Glamour and Grace!",
    date: "18 May 2024",
    location: 'Essex',
    img: "https://ichef.bbci.co.uk/news/976/cpsprodpb/DF88/production/_106642275_tv053643519.jpg"
  },

  {
    title: "Paw and Order: A Movie Day for Paws and Claws!",
    description: "Get ready for a cinematic adventure like no other at Paw and Order - the ultimate movie day for you!",
    date: "14 June 2024",
    location: 'Soho, London',
    img: "https://m.media-amazon.com/images/M/MV5BMjMwODg2NDA2MV5BMl5BanBnXkFtZTgwNDI1Mjg5NDM@._V1_.jpg"
  },

  {
    title: "Grooming Glamour: Pamper Your Paws at Grooming Day!",
    description: "Treat your furry friends to a day of luxury and relaxation at Grooming Glamour!",
    date: "22 June 2024",
    location: 'London',
    img: "https://www.mutneys.com/wp-content/uploads/2019/08/OpawzBlowPens-Dog-Sample.jpg"
  }
]

events.each do |event|
  user = User.all.sample
  temp_event = Event.new(title: event[:title], description: event[:description], location: event[:location], date: event[:date], user_id: user.id)
  file = URI.open(event[:img])
  temp_event.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  temp_event.save
end

puts "Events created!"
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
