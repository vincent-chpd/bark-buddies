require 'faker'
require 'open-uri'

Community.destroy_all
Conversation.destroy_all
Message.destroy_all
Event.destroy_all
User.destroy_all
Dog.destroy_all

puts "Creating real users..."

## Vincent's profile
vincent = User.create(
  name: "Vincent",
  email: "vincent@vincent.com",
  password: '123456',
  location: "Hoxton",
  age: 28,
  bio: "Just moved to London and looking for some dog friends. Send me a message if you want to meet up for a walk!"
)
file = URI.open('https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1697808207/fococnbp64dtyybgvzec.jpg')
vincent.photo.attach(io: file, filename: "vincent.png", content_type: 'image/png')
vincent.save

vincent_dog = Dog.create(
  name: "Luffy",
  age: 1,
  breed: "Pembroke Welsh Corgi",
  gender: "male",
  bio: "I'm a friendly corgi who loves to play and meet new friends!",
  user_id: vincent.id
)

luffy_photos = [
  'https://pethelpful.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:eco%2Cw_1200/MTkyNjM2NjExNzgxOTkzOTA4/shutterstock_1342321847.jpg',
  'https://corgicare.com/wp-content/uploads/how-much-attention-do-corgis-need-fun-activities.jpg'
]

luffy_photos.each do |photo, index|
  file = URI.open(photo)
  vincent_dog.photos.attach(io: file, filename: "luffy#{index}.png", content_type: 'image/png')
end
vincent_dog.save

## Luca's profile
luca = User.create(
  name: "Luca",
  email: "luca@luca.com",
  password: '123456',
  location: "Kilburn",
  age: 30,
  bio: "Looking to meet other dog owners in the area. I have a friendly golden retriever who loves to play with other dogs!"
)
file = URI.open('https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1705006005/vzzyayojrtu8cxenstzi.jpg')
luca.photo.attach(io: file, filename: "luca.png", content_type: 'image/png')
luca.save

luca_dog = Dog.create(
  name: "Ceasar",
  age: 3,
  breed: "Golden retriever",
  gender: "male",
  bio: "I'm a friendly golden retriever who loves to play and meet new friends! I'm very friendly and love to play with other dogs.",
  user_id: luca.id
)

ceasar_photos = [
  'https://www.dailypaws.com/thmb/DQfQglzyKWlVSlsDwKPprF2iMSg=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/golden-retriever-177213599-2000-a30830f4d2b24635a5d01b3c5c64b9ef.jpg',
  'https://pethelpful.com/.image/ar_4:3%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_xy_center%2Cq_auto:eco%2Cw_1200%2Cx_3086%2Cy_1421/MTkwMjIwNTkyMjgzMTMzMjcw/shutterstock_610623968.jpg'
]

ceasar_photos.each do |photo, index|
  file = URI.open(photo)
  luca_dog.photos.attach(io: file, filename: "ceasar#{index}.png", content_type: 'image/png')
end
luca_dog.save

puts "Real users created!"
puts "Creating fake users..."

users = [] # Define an empty array to store created users
boroughs = %w[Hackney Croydon Camden Stratford Shoreditch Lambeth Newham Greenwich Lewisham Southwark Islington Westminster Hoxton Fulham]

20.times do |i|
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

puts "Fake users created!"
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
    description: "Unleash the joy and let the fur fly at our Happy Hour for Hounds! Indulge in delicious treats for both humans and dogs alike, mingle with fellow dog lovers, and enjoy a variety of activities guaranteed to make tails wag.",
    # turn this into a date.
    date: "20 April 2024",
    location: 'Reading',
    img: "https://media.istockphoto.com/id/162055755/photo/martini-dog.jpg?s=612x612&w=0&k=20&c=AQV8oHGakter-SuLHvHPuWj9btrbUQ2JpDelsQjwM7I="
  },
  {
    title: "Paws in Motion: Walkathon for Dogs!",
    description: "Get ready to put your best paw forward at Paws in Motion, the ultimate event for dogs!
    Embark on an adventure like no other as we transform the park into a playground for pups of all shapes and sizes.",
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
    title: "Cinema Day: A Movie Day for Paws and Claws!",
    description: "Get ready for a cinematic adventure like no other at Paw and Order - the ultimate movie day for you!",
    date: "14 June 2024",
    location: 'Soho, London',
    img: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/6gmvu2hxdfnQ55LZZjyzYR4kzGk/AAAABRsgD-4khUGuGjIj3RrN-Tv8xQWAPLs07geUnat-pifJCdF5DCqj-tTCCh59Y9ZmEZir75VKIG5eTHjQ2hQBiPzW8xDPcJNkRB6RtyD4ERKIFO4GGwFIjOSgxuycoMqmhB0c3Q.jpg?r=f7b"
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

communities = [
  {
    name: "Corgi lovers",
    description: "A community for all corgi lovers to share their love for the breed and meet other corgi owners!",
    photo: "https://www.akc.org/wp-content/uploads/2017/11/Pembroke-Welsh-Corgi-standing-outdoors-in-the-fall.jpg"
  },
  {
    name: "Pomeranian lovers",
    description: "A community for all pomeranian lovers to share their love for the breed and meet other pomeranian owners!",
    photo: "https://media-be.chewy.com/wp-content/uploads/2021/04/18141250/iStock-1422682177-923x615.jpg"
  },
  {
    name: "Pug lovers",
    description: "A community for all pugs lovers to share their love for the breed and meet other pugs owners!",
    photo: "https://www.vettimes.co.uk/app/uploads/2022/05/pug-2035675-scaled.jpg"
  },
  {
    name: "Yorkshire Terrier",
    description: "A community for all Yorkshire Terrier lovers to share their love for the breed and meet other Yorkshire Terrier owners!",
    photo: "https://www.yorkshire.com/wp-content/uploads/2022/10/yorkshire-terrier-on-grass.jpg"
  },
  {
    name: "Golden retriever",
    description: "A community for all Golden retriever lovers to share their love for the breed and meet other Golden retriever owners!",
    photo: "https://13630656.rocketcdn.me/wp-content/uploads/2020/01/Golden4.jpg"
  },
  {
    name: "French bulldog",
    description: "A community for all French bulldog lovers to share their love for the breed and meet other French bulldog owners!",
    photo: "https://cdn.britannica.com/44/233844-050-A0F9F39C/French-bulldog.jpg"
  },
  {
    name: "East London Dog Walkers",
    description: "A community for all dog owners in East London to meet and organise dog walks!",
    photo: "https://romanroadlondon.com/wp-content/uploads/2018/02/Screen-Shot-2018-02-12-at-16.07.54.png"
  },
  {
    name: "Cool dogs of shoreditch",
    description: "The coolest dogs in Shoreditch! Join us for meetups and events in the area.",
    photo: "https://static.standard.co.uk/s3fs-public/thumbnails/image/2014/06/05/10/dogphoto10.jpg?crop=8:5,smart&quality=75&auto=webp&width=1024"
  }
]

communities.each do |community|
  breed_community = Community.new(name: community[:name], description: community[:description])
  breed_community.photo.attach(io: URI.open(community[:photo]), filename: "nes.png", content_type: "image/png")
  breed_community.save
end

puts "Communities created!"
