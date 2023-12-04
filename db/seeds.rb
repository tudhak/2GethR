# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Destroying reward templates (generic rewards)..."
GenericReward.destroy_all

puts "Destroying status..."
Statue.destroy_all

puts "Destroying mood categories..."
MoodCategory.destroy_all

puts "Destroying reward instances (Rewards)..."
Reward.destroy_all

puts "Destroying task templates (generic tasks)..."
GenericTask.destroy_all

puts "Destroying task instances (tasks)..."
Task.destroy_all

puts "Destroying users..."
User.destroy_all

puts "Destroying couples..."
Couple.destroy_all

puts "Creating couples..."
couple1 = Couple.create(address: '12 rue de passy', token: 123456)
couple2 = Couple.create(address: '58 rue pierre charron', token: 789012)
puts "Couples created"

puts "Creating users"
user1 = User.create(
  email: 'user1@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  last_name: 'Dujardin',
  first_name: 'Jean',
  nickname: 'Loulou',
  date_of_birth: Date.parse('1990-01-01'),
  score: 100,
  mode: 'normal',
  couple: couple1
)
user1.photo.attach(io: URI.open("https://www.ecranlarge.com/media/cache/155x155/uploads/image/000/965/fpnjxvl3i4atlsmwjqmvzdr4twi-724.jpg"), filename: "user1.jpg", content_type: "image/jpg")


user2 = User.create(
  email: 'user2@example.com',
  password: 'password456',
  password_confirmation: 'password456',
  last_name: 'Lamy',
  first_name: 'Alexandra',
  nickname: 'Chouchou',
  date_of_birth: Date.parse('1992-03-15'),
  score: 120,
  mode: 'normal',
  couple: couple1
)
user2.photo.attach(io: URI.open("https://www.ecranlarge.com/media/cache/155x155/uploads/image/000/978/b7qnddsqzri4wfy26msigfmftho-468.jpg"), filename: "user2.jpg", content_type: "image/jpg")

user3 = User.create(
  email: 'user3@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  last_name: 'Kardashian',
  first_name: 'Kimberly',
  nickname: 'Kim',
  date_of_birth: Date.parse('1980-10-21'),
  score: 80,
  mode: 'normal',
  couple: couple2
)
user3.photo.attach(io: URI.open("https://img-3.journaldesfemmes.fr/Si7QKJ-qnM9z6DN9XzKSH7ilc3U=/1500x/smart/45ebd918085745208e74acd424eb68c0/ccmcms-jdf/39927151.jpg"), filename: "user3.jpg", content_type: "image/jpg")

user4 = User.create(
  email: 'user4@example.com',
  password: 'password345',
  password_confirmation: 'password345',
  last_name: 'West',
  first_name: 'Kanye',
  nickname: 'Ye',
  date_of_birth: Date.parse('1977-06-08'),
  score: 120,
  mode: 'normal',
  couple: couple2
)
user4.photo.attach(io: URI.open("https://ngroup.gumlet.io/IMAGE/IMAGE-S1-00016/68445-kanye-west.jpg?w=600"), filename: "user4.jpg", content_type: "image/jpg")

puts "Users created."

#------------------------------Mood Categories----------------------------------

puts "Creating Mood Categories"

mood_cat = [
  {title: "stormy", url: "https://gifdb.com/images/high/lightning-strikes-from-different-angles-nmtna33cvgzsao7g.gif"},
  {title: "rainy", url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLuW0GIlrYKhIzynv9ITRKUnVzFvDkD5LU9Q&usqp=CAU"},
  {title: "cloudy", url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBeFuUS1xlGXN994FpFwVLhmZgUhEIfl8FDg&usqp=CAU"},
  {title: "sunny", url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGv6foDhUwklEvERo1MuHykzepVY8cc64ipQ&usqp=CAU"}
]

mood_cat.each { |mood| MoodCategory.create(title: mood[:title], image_path: mood[:url]) }

puts "Four Categories created"

#------------------------------Status-------------------------------------------
#---------------------------Status_User2----------------------------------------
puts "Creating status for user2"
puts "...7 days ago"

Statue.create(
  mood_category: MoodCategory.all[3],
  user: user2,
  start_date: Time.now - 86400*7,
  main_statue_message: "Love you darling!",
  love_statue_message: "We could go out and dance tonight",
)

puts "...5 fays ago"

Statue.create(
  mood_category: MoodCategory.all[1],
  user: user2,
  start_date: Time.now - 86400*5,
  main_statue_message: "You better have a good reason for not returning my calls!",
  love_statue_message: "you prepare a nice dinner tonight",
  hate_statue_message: "you do not recall my call!"
)

puts "...4 days ago"

Statue.create(
  mood_category: MoodCategory.all[2],
  user: user2,
  start_date: Time.now - 86400*4,
  main_statue_message: "You're so annoying!",
  love_statue_message: "you apologize and make it up to me!" ,
  hate_statue_message: "you forget my birthday!"
)

puts "...2 days ago"

Statue.create(
  mood_category: MoodCategory.all[0],
  user: user2,
  start_date: Time.now - 86400*2,
  main_statue_message: "Don't even talk to me!",
  love_statue_message: "you clean up your mess! ",
  hate_statue_message: "you come back completely drunk at 5am and trow up in the bed!"
)

user2stat = user2.statues

user2stat.each_with_index do |status, index|
  status[:end_date] = user2stat[index+1].nil? ? Time.now : user2stat[index+1].start_date
  status.save
end
user2stat.last[:end_date] = nil
user2stat.last.save


puts "4 status created for user 2"

#---------------------------Status_User1----------------------------------------
puts "Creating status for user1"
puts "...7 days ago"

Statue.create(
  mood_category: MoodCategory.all[0],
  user: user1,
  start_date: Time.now - 86400*7,
  main_statue_message: "You drive me f**in' maad!",
  love_statue_message: "you can leave my stuff where they are! ",
  hate_statue_message: "you think you're tidying up but are in fact just hiddin stuff!"

)

puts "...5 days ago"

Statue.create(
  mood_category: (MoodCategory.all[1]),
  user: user1,
  start_date: Time.now - 86400*5,
  main_statue_message: "Not so happy",
  love_statue_message: "you can leave my stuff where they are! ",
  hate_statue_message: "you think you're tidying up but are in fact just hiddin stuff!"

)

puts "...3 days ago"

Statue.create(
  mood_category: (MoodCategory.all[3]),
  user: user1,
  start_date: Time.now - 86400*3,
  main_statue_message: "Life is good!",
  love_statue_message: "I could spend the week-end with my homies",
  love_statue_message: "it's soccer game night and you make me watch The f**ing notebook! "
)

puts "...yesterday"

Statue.create(
  mood_category: (MoodCategory.all[2]),
  user: user1,
  start_date: Time.now - 86400,
  main_statue_message: "So so",
  love_statue_message: "you can leave my stuff where they are! ",
  hate_statue_message: "you think you're tidying up but are in fact just hiddin stuff!"
)


user1stat = user1.statues

user1stat.each_with_index do |status, index|
  status[:end_date] = user1stat[index+1].nil? ? Time.now : user1stat[index+1].start_date
  status.save
end
user1stat.last[:end_date] = nil
user1stat.last.save

puts "4 status created for user 1"

#---------------------------Status_User4----------------------------------------
puts "Creating status for user4"
puts "...7 days ago"
Statue.create(
  mood_category: MoodCategory.all[0],
  user: user4,
  start_date: Time.now - 85400*7,
  main_statue_message: "You drive me f**in' maad!",
  love_statue_message: "you can leave my stuff where they are! ",
  hate_statue_message: "you think you're tidying up but are in fact just hiddin stuff!"
)

puts "...4 days ago"

Statue.create(
  mood_category: MoodCategory.all[1],
  user: user4,
  start_date: Time.now - 85400*4,
  main_statue_message: "Not so happy",
  love_statue_message: "you can leave my stuff where they are! ",
  hate_statue_message: "you think you're tidying up but are in fact just hiddin stuff!"

)

puts "...3 days ago"

Statue.create(
  mood_category: MoodCategory.all[2],
  user: user4,
  start_date: Time.now - 85400*3,
  main_statue_message: "So so",
  love_statue_message: "you can leave my stuff where they are! ",
  hate_statue_message: "you think you're tidying up but are in fact just hiddin stuff!"

)

puts "...2 days ago"

Statue.create(
  mood_category: MoodCategory.all[3],
  user: user4,
  start_date: Time.now - 85400*2,
  main_statue_message: "Life is good!",
  love_statue_message: "I could spend the week-end with my homies",
  love_statue_message: "it's soccer game night and you make me watch The f**ing notebook! "
)

user4stat = user4.statues

user4stat.each_with_index do |status, index|
  status[:end_date] = user4stat[index+1].nil? ? Time.now : user4stat[index+1].start_date
  status.save
end
user4stat.last[:end_date] = nil
user4stat.last.save


puts "4 status created for user 4"

#---------------------------Status_User3----------------------------------------
puts "Creating status for user3"
puts "...7 days ago"

Statue.create(
  mood_category: MoodCategory.all[0],
  user: user3,
  start_date: Time.now - 85400*7,
  main_statue_message: "Don't even talk to me!",
  love_statue_message: "you clean up your mess! ",
  hate_statue_message: "you come back completely drunk at 5am and trow up in the bed!"
)

puts "...6 days ago"

Statue.create(
  mood_category: (MoodCategory.all[1]),
  user: user3,
  start_date: Time.now - 85400*6,
  main_statue_message: "You better have a good reason for not returning my calls!",
  love_statue_message: "you prepare a nice dinner tonight",
  hate_statue_message: "you do not recall my call!"
)

puts "...3 days ago"

Statue.create(
  mood_category: (MoodCategory.all[2]),
  user: user3,
  start_date: Time.now - 85400*3,
  main_statue_message: "You're so annoying!",
  love_statue_message: "you apologize and make it up to me!" ,
  hate_statue_message: "you forget my birthday!"

)

puts "...2 days ago"

Statue.create(
  mood_category: (MoodCategory.all[0]),
  user: user3,
  start_date: Time.now - 85400*2,
  main_statue_message: "Don't even talk to me!",
  love_statue_message: "you clean up your mess! ",
  hate_statue_message: "you come back completely drunk at 5am and trow up in the bed!"

)

user3stat = user3.statues

user3stat.each_with_index do |status, index|
  status[:end_date] = user3stat[index+1].nil? ? Time.now : user3stat[index+1].start_date
  status.save
end
user3stat.last[:end_date] = nil
user3stat.last.save

puts "4 status created for user 3"

#------------------------------Task templates----------------------------------

puts "Creating task templates (generic tasks)..."

GenericTask.create(
  title: "Let the dogs out",
  description: "The dogs should take a walk to keep the flat clean.",
  base_score: 30,
  couple: couple1
)

GenericTask.create(
  title: "Do the dishes",
  description: "Keeping the kitchen clean is a good medicine.",
  base_score: 40,
  couple: couple1
)

GenericTask.create(
  title: "Iron clothes",
  description: "A little ironing to have presentable outfits.",
  base_score: 25,
  couple: couple1
)

GenericTask.create(
  title: "Full house cleaning",
  description: "Basic hygiene for a better life.",
  base_score: 60,
  couple: couple1
)

GenericTask.create(
  title: "Vacuum",
  description: "Keep the house tidy with some vacuum cleaning.",
  base_score: 15,
  couple: couple2
)

GenericTask.create(
  title: "Prepare the dinner",
  description: "Cook some good food.",
  base_score: 50,
  couple: couple2
)

GenericTask.create(
  title: "Wash and hang clothes",
  description: "Taking showers is not enough, our clothes also have to smell good.",
  base_score: 35,
  couple: couple2
)

GenericTask.create(
  title: "Change the bedding",
  description: "A fresh bed for a deep sleep.",
  base_score: 30,
  couple: couple2
)

GenericTask.create(
  title: "Other",
  couple: couple1
)

GenericTask.create(
  title: "Other",
  couple: couple2
)

puts "Task templates created."

#------------------------------Task instances----------------------------------

puts "Creating task instances (tasks)..."

Task.create(
  title: "Feed the fishes",
  description: "Feed our lovely fishes with adapted pet food.",
  date: Date.parse("30/11/2023"),
  base_score: 15,
  user: user2,
  status: "pending",
  assigned_to: "Loulou"
)

Task.create(
  title: "Water the plants",
  description: "Our plants look rather dry.",
  date: Date.parse("01/12/2023"),
  base_score: 15,
  user: user2,
  status: "pending",
  assigned_to: "any"
)

Task.create(
  title: "Book winter holidays",
  description: "Time flies. Please take some time to book our next holidays.",
  date: Date.parse("30/11/2023"),
  base_score: 70,
  user: user2,
  status: "pending",
  assigned_to: "Loulou"
)

Task.create(
  title: "Clean the carpet",
  description: "There is dust all over the carpet. It pisses me off.",
  date: Date.parse("06/12/2023"),
  base_score: 15,
  user: user2,
  status: "pending",
  assigned_to: "any"
)

Task.create(
  title: "Buy a gift for my nephew",
  description: "I think he likes video games.",
  date: Date.parse("15/12/2023"),
  base_score: 50,
  user: user4,
  status: "pending",
  assigned_to: "Kim"
)

Task.create(
  title: "Order some wine for Christmas",
  description: "Please take some quality wine this time. I don't like piss.",
  date: Date.parse("16/12/2023"),
  base_score: 40,
  user: user3,
  status: "pending",
  assigned_to: "Kim"
)

Task.create(
  title: "Take my dress to the dry cleaning",
  description: "There are some blemishes on my dress I would like to get rid of.",
  date: Date.parse("09/12/2023"),
  base_score: 25,
  user: user3,
  status: "pending",
  assigned_to: "Ye"
)

Task.create(
  title: "Go to the grocery store",
  description: "We ran out of pasta.",
  date: Date.parse("12/12/2023"),
  base_score: 25,
  user: user1,
  status: "pending",
  assigned_to: "any"
)

Task.create(
  title: "Fix the cupboard",
  description: "I can't stand this defective cupboard anymore. Do something.",
  date: Date.parse("07/12/2023"),
  base_score: 30,
  user: user3,
  status: "pending",
  assigned_to: "Ye"
)

Task.create(
  title: "Send back my headphones for refund",
  description: "This garbage does not work.",
  date: Date.parse("08/12/2023"),
  base_score: 25,
  user: user4,
  status: "pending",
  assigned_to: "any"
)

Task.create(
  title: "Buy some painkillers at the drugstore",
  description: "My back hurts.",
  date: Date.parse("02/12/2023"),
  base_score: 25,
  user: user4,
  status: "pending",
  assigned_to: "any"
)

Task.create(
  title: "Change the bedding",
  description: "A fresh bed for a deep sleep.",
  date: Date.parse("03/12/2023"),
  base_score: 30,
  user: user1,
  status: "pending",
  assigned_to: "any"
)

Task.create(
  title: "Do the dishes",
  description: "Keeping the kitchen clean is a good medicine.",
  date: Date.parse("01-12-2023"),
  base_score: 40,
  user: user2,
  status: "pending",
  assigned_to: "any"
)

puts "Task instances created."

GenericReward.create!(
  title: 'Movie Night',
  description: 'Enjoy a movie night together.',
  cost: 50,
  couple: couple1
)
GenericReward.create!(
  title: 'Dinner Date',
  description: 'Have a romantic dinner at your favorite restaurant.',
  cost: 80,
  couple: couple1
)
GenericReward.create!(
  title: 'Weekend Getaway',
  description: 'Plan a weekend getaway to relax and unwind.',
  cost: 150,
  couple: couple1
)

Reward.create!(
  date: "02/12/2023",
  user: user1,
  status: 'pending',
  description: 'A special reward',
  title: 'Special Reward',
  cost: 100
)

Reward.create!(
  date: "06/12/2023",
  user: user1,
  status: 'done',
  description: 'A well deserved massage',
  title: 'Special Massage',
  cost: 100
)

Reward.create!(
  date: "02/12/2023",
  user: user2,
  status: 'pending',
  description: 'Another reward',
  title: 'Another Reward',
  cost: 75
)

Reward.create!(
  date: "02/12/2023",
  user: user2,
  status: 'done',
  description: 'A rejected reward',
  title: 'Rejected Reward',
  cost: 120
)

puts 'Seed data for rewards created successfully!'
