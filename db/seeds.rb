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
  location: "shoreditch",
  age: 30,
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
  'https://primary.jwwb.nl/unsplash/uc3JhSWITMo.jpg',
  'https://www.petlandsanantonio.com/wp-content/uploads/2023/05/2315792_800-600x450.jpg'
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
  location: "Shoreditch",
  age: 30,
  followers: 69,
  communities: 5,
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

## isaac's profile
isaac = User.create(
  name: "Isaac",
  email: "isaac@isaac.com",
  password: '123456',
  location: "Shoreditch",
  age: 29,
  followers: 93,
  communities: 3,
  bio: "I'm a dog lover and have a friendly french bulldog named Erling. Looking to meet other dog owners in the area"
)
file = URI.open('https://ca.slack-edge.com/T02NE0241-U061W4UGPSR-a589caaa3cbf-512')
isaac.photo.attach(io: file, filename: "isaac.png", content_type: 'image/png')
isaac.save

isaac_dog = Dog.create(
  name: "Erling",
  age: 4,
  breed: "French Bulldog",
  gender: "male",
  bio: "I love to play ball and snuggle up on the sofa.",
  user_id: isaac.id
)

erling_photos = [
  'https://www.dogsy.co.uk/cdn/shop/files/dogshirt4.jpg?v=1699375757&width=1000',
  'https://www.purina.co.uk/sites/default/files/styles/crop_breed_ugc_image/public/webform/breed_ugc/161244/aa27217c-107b-46fb-96e9-314207dd9aa1.jpeg?h=f7874e80&itok=5WTkedGb'
]

erling_photos.each do |photo, index|
  file = URI.open(photo)
  isaac_dog.photos.attach(io: file, filename: "erling#{index}.png", content_type: 'image/png')
end
isaac_dog.save

###################### Tom's profile
tom = User.create(
  name: "Tom",
  email: "tom@tom.com",
  password: '123456',
  location: "Shoreditch",
  age: 25,
  followers: 89,
  communities: 4,
  bio: "I'm a dog lover and have a friendly pug named Max. Looking to meet other dog owners in the area!"
)
file = URI.open('https://ca.slack-edge.com/T02NE0241-U046DRSC3J4-2405583ed0d5-512')
tom.photo.attach(io: file, filename: "tom.png", content_type: 'image/png')
tom.save

tom_dog = Dog.create(
  name: "Max",
  age: 2,
  breed: "Pug",
  gender: "male",
  bio: " I'm a jolly pug who's always up for a playdate and making new fur-iends!",
  user_id: tom.id
)

max_photos = [
  'https://pug.tips/wp-content/uploads/2019/01/Small-pug-puppy-fawn.jpg',
  'https://www.wallmonkeys.com/cdn/shop/products/5837886-LRG_530x.jpg?v=1578662125'
]

max_photos.each do |photo, index|
  file = URI.open(photo)
  tom_dog.photos.attach(io: file, filename: "max#{index}.png", content_type: 'image/png')
end
tom_dog.save

###################### Harry's profile
harry = User.create(
  name: "Harry",
  email: "harry@harry.com",
  password: '123456',
  location: "Shoreditch",
  age: 26,
  followers: 10,
  communities: 2,
  bio: "I'm a dog lover and have a friendly pug named Max. Looking to meet other dog owners in the area!"
)
file = URI.open('https://slack-imgs.com/?c=1&o1=ro&url=https%3A%2F%2Fi.imgur.com%2F9yIGrCa.png')
harry.photo.attach(io: file, filename: "harry.png", content_type: 'image/png')
harry.save

harry_dog = Dog.create(
  name: "Bella",
  age: 4,
  breed: "Golden labrador",
  gender: "Female",
  bio: " I'm a jolly pug who's always up for a playdate and making new fur-iends!",
  user_id: harry.id
)

bella_photos = [
  'https://i.imgur.com/65fNHIH.png',
  'https://i.imgur.com/qsdFIpe.png'
]

bella_photos.each do |photo, index|
  file = URI.open(photo)
  harry_dog.photos.attach(io: file, filename: "bella#{index}.png", content_type: 'image/png')
end
harry_dog.save

puts "Real users created!"
puts "Creating fake users..."

users = [] # Define an empty array to store created users
boroughs = %w[Hackney Croydon Camden Stratford Shoreditch Lambeth Newham Greenwich Lewisham Southwark Islington Westminster Hoxton Fulham]

15.times do |i|
  user = User.create(
    name: Faker::Name.first_name,
    email: "user#{i}@user.com",
    password: '123456',
    location: boroughs.sample,
    age: rand(25..30),
    bio: Faker::Lorem.paragraph,
    followers: rand(1..100),
    communities: rand(1..10)
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
      bio: Faker::Lorem.paragraph,
      user_id: user.id
    )

    1.times do |photo_index|
      file = URI.open('https://placedog.net/640/480?random')
      dog.photos.attach(io: file, filename: "dog#{user_index + 1}_photo#{photo_index + 1}.png", content_type: 'image/png')
    end
  end
end

puts "Dogs created!"

puts "Creating events!"
events = [
  {
    title: "Yappy Hour Extravaganza!",
    description: "Unleash the joy and let the fur fly at our Happy Hour for Hounds! Indulge in delicious treats for both humans and dogs alike, mingle with fellow dog lovers, and enjoy a variety of activities guaranteed to make tails wag.",
    # turn this into a date.
    date: "06 April 2024",
    location: 'Kings Cross, London',
    img: "https://i2-prod.liverpoolecho.co.uk/whats-on/food-drink-news/article14921477.ece/ALTERNATES/s615/0_JS157770132.jpg"
  },
  {
    title: "Paws in Motion Walkathon!",
    description: "Get ready to put your best paw forward at Paws in Motion, the ultimate event for dogs!
    Embark on an adventure like no other as we transform the park into a playground for pups of all shapes and sizes.",
    date: "07 April 2024",
    location: 'Victoria Park, London',
    img: "https://www.rauanimalhospital.com/sites/default/files/summertime-events-for-dogs-blog-header.jpg"
  },
  {
    title: "Kindness Day: Love to All!",
    description: "Join us for a heartwarming celebration of kindness, where small acts of compassion make differences!",
    date: "13 April 2024",
    location: 'Earlsfield, London',
    img: "https://k9nation.dog/k9nation/wp-content/uploads/2022/03/Dog-Events-Feature.jpeg"
  },

  {
    title: "Glits and Grace: A Pageant Show!",
    description: "Step into the spotlight and experience the magic of Glamour and Grace!",
    date: "11 May 2024",
    location: 'Shoreditch, London',
    img: "https://ichef.bbci.co.uk/news/976/cpsprodpb/DF88/production/_106642275_tv053643519.jpg"
  },

  {
    title: "Cinema Day: Movie Day for Paws and Claws!",
    description: "Get ready for a cinematic adventure like no other at Paw and Order - the ultimate movie day for you!",
    date: "18 May 2024",
    location: 'Soho, London',
    img: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/6gmvu2hxdfnQ55LZZjyzYR4kzGk/AAAABRsgD-4khUGuGjIj3RrN-Tv8xQWAPLs07geUnat-pifJCdF5DCqj-tTCCh59Y9ZmEZir75VKIG5eTHjQ2hQBiPzW8xDPcJNkRB6RtyD4ERKIFO4GGwFIjOSgxuycoMqmhB0c3Q.jpg?r=f7b"
  },

  {
    title: "Grooming Glamour: Pamper Your Paws!",
    description: "Treat your furry friends to a day of luxury and relaxation at Grooming Glamour!",
    date: "18 May 2024",
    location: 'Hackney, London',
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
    name: "Corgilicious",
    description: "A community for all corgi lovers to share their love for the breed and meet other corgi owners!",
    photo: "https://www.akc.org/wp-content/uploads/2017/11/Pembroke-Welsh-Corgi-standing-outdoors-in-the-fall.jpg"
  },
  {
    name: "Pom-Pom Pals",
    description: "A community for all pomeranian lovers to share their love for the breed and meet other pomeranian owners!",
    photo: "https://media-be.chewy.com/wp-content/uploads/2021/04/18141250/iStock-1422682177-923x615.jpg"
  },
  {
    name: "Pugtastic Pals",
    description: "A community for all pugs lovers to share their love for the breed and meet other pugs owners!",
    photo: "https://www.vettimes.co.uk/app/uploads/2022/05/pug-2035675-scaled.jpg"
  },
  {
    name: " Yorkie Yodelers",
    description: "A community for all Yorkshire Terrier lovers to share their love for the breed and meet other Yorkshire Terrier owners!",
    photo: "https://www.yorkshire.com/wp-content/uploads/2022/10/yorkshire-terrier-on-grass.jpg"
  },
  {
    name: "Goldie Gigglers",
    description: "A community for all Golden retriever lovers to share their love for the breed and meet other Golden retriever owners!",
    photo: "https://13630656.rocketcdn.me/wp-content/uploads/2020/01/Golden4.jpg"
  },
  {
    name: "Frenchie Funsters",
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
  },
  {
    name: "Clapham Canines",
    description: "The coolest dogs in Shoreditch! Join us for meetups and events in the area.",
    photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTccpfXB_m-g84W3jDB3csWX3q9zYYmXZnioA&usqp=CAU"
  },
  {
    name: "Battersea buddies",
    description: "The coolest dogs in Shoreditch! Join us for meetups and events in the area.",
    photo: "https://metro.co.uk/wp-content/uploads/2015/12/battersea-pic.jpg?quality=80&strip=all"
  }
]

communities.each do |community|
  breed_community = Community.new(name: community[:name], description: community[:description])
  breed_community.photo.attach(io: URI.open(community[:photo]), filename: "nes.png", content_type: "image/png")
  breed_community.save
end

puts "Communities created!"
