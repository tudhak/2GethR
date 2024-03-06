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
couple1 = Couple.create(nickname: "Chouchou & Loulou", address: '12 rue de passy 75016 Paris', token: "123_456")
couple2 = Couple.create(nickname: "Kim & Ye", address: '58 rue pierre charron 75008 Paris', token: "789_012")
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
user2.photo.attach(io: URI.open("https://www.ecranlarge.com/media/cache/155x155/uploads/image/000/978/b7qnddsqzri4wfy26msigfmftho-468.jpg"),
                   filename: "user2.jpg", content_type: "image/jpg")

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
user3.photo.attach(io: URI.open("https://img-3.journaldesfemmes.fr/Si7QKJ-qnM9z6DN9XzKSH7ilc3U=/1500x/smart/45ebd918085745208e74acd424eb68c0/ccmcms-jdf/39927151.jpg"),
                   filename: "user3.jpg", content_type: "image/jpg")

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
user4.photo.attach(io: URI.open("https://ngroup.gumlet.io/IMAGE/IMAGE-S1-00016/68445-kanye-west.jpg?w=600"),
                   filename: "user4.jpg", content_type: "image/jpg")

puts "Users created."

#------------------------------Mood Categories----------------------------------

puts "Creating Mood Categories"

mood_cat = [
  {title: "stormy", url: "https://gifdb.com/images/high/lightning-strikes-from-different-angles-nmtna33cvgzsao7g.gif"},
  {title: "rainy", url:"https://usagif.com/wp-content/uploads/rainy-6.gif"},
  {title: "cloudy", url:"https://media.tenor.com/tQWmGFB9_SYAAAAd/moving-clouds-world-meteorological-day.gif"},
  {title: "sunny", url:"https://64.media.tumblr.com/c4205bb1f4230f38c8e79b49055a9c67/b4d4f2e5ea6f4d8e-78/s640x960/a14a1b8f48c5d728c499c6ca9f2922003866bb63.gif"}
]

mood_cat.each { |mood| MoodCategory.create(title: mood[:title], image_path: mood[:url]) }

puts "Four Categories created"

#------------------------------Status-------------------------------------------
#---------------------------Status_User2----------------------------------------
puts "Creating status for user2"

puts "...30 days ago"

Statue.create(
  mood_category: MoodCategory.all[0],
  user: user2,
  start_date: Time.now - (86_400 * 30),
)

puts "...27 days ago"

Statue.create(
  mood_category: MoodCategory.all[1],
  user: user2,
  start_date: Time.now - (86_400 * 27),
)

puts "...22 days ago"

Statue.create(
  mood_category: MoodCategory.all[2],
  user: user2,
  start_date: Time.now - (86_400 * 22),
)

puts "...18 days ago"

Statue.create(
  mood_category: MoodCategory.all[3],
  user: user2,
  start_date: Time.now - (86_400 * 18),
)

puts "...15 days ago"

Statue.create(
  mood_category: MoodCategory.all[0],
  user: user2,
  start_date: Time.now - (86_400 * 15),
)

puts "...12 days ago"

Statue.create(
  mood_category: MoodCategory.all[1],
  user: user2,
  start_date: Time.now - (86_400 * 12),
)

puts "...9 days ago"

Statue.create(
  mood_category: MoodCategory.all[3],
  user: user2,
  start_date: Time.now - (86_400 * 9),
)

puts "...7 days ago"

Statue.create(
  mood_category: MoodCategory.all[3],
  user: user2,
  start_date: Time.now - (86_400 * 7),
  main_statue_message: "Love you darling!",
  love_statue_message: "We could go out and dance tonight",
)

puts "...5 days ago"

Statue.create(
  mood_category: MoodCategory.all[1],
  user: user2,
  start_date: Time.now - (86_400 * 5),
  main_statue_message: "You better have a good reason for not returning my calls!",
  love_statue_message: "you prepare a nice dinner tonight",
  hate_statue_message: "you do not recall my call!"
)

puts "...4 days ago"

Statue.create(
  mood_category: MoodCategory.all[2],
  user: user2,
  start_date: Time.now - (86_400 * 4),
  main_statue_message: "You're so annoying!",
  love_statue_message: "you apologize and make it up to me!",
  hate_statue_message: "you forget my birthday!"
)

puts "...2 days ago"

Statue.create(
  mood_category: MoodCategory.all[0],
  user: user2,
  start_date: Time.now - (86_400 * 2),
  main_statue_message: "Don't even want to hear from you!",
  love_statue_message: "you could clean up your mess!",
  hate_statue_message: "you come back completely drunk at 5am and mistake my dressing for the toilets!"
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

puts "...30 days ago"

Statue.create(
  mood_category: MoodCategory.all[0],
  user: user1,
  start_date: Time.now - (86_400 * 30),
)

puts "...27 days ago"

Statue.create(
  mood_category: MoodCategory.all[1],
  user: user1,
  start_date: Time.now - (86_400 * 27),
)

puts "...22 days ago"

Statue.create(
  mood_category: MoodCategory.all[2],
  user: user1,
  start_date: Time.now - (86_400 * 22),
)

puts "...18 days ago"

Statue.create(
  mood_category: MoodCategory.all[3],
  user: user1,
  start_date: Time.now - (86_400 * 18),
)

puts "...15 days ago"

Statue.create(
  mood_category: MoodCategory.all[0],
  user: user1,
  start_date: Time.now - (86_400 * 15),
)

puts "...12 days ago"

Statue.create(
  mood_category: MoodCategory.all[1],
  user: user1,
  start_date: Time.now - (86_400 * 12),
)

puts "...9 days ago"

Statue.create(
  mood_category: MoodCategory.all[3],
  user: user1,
  start_date: Time.now - (86_400 * 9),
)

puts "...7 days ago"

Statue.create(
  mood_category: MoodCategory.all[0],
  user: user1,
  start_date: Time.now - (86_400 * 7),
  main_statue_message: "You drive me f**in' maad!",
  love_statue_message: "you can leave my stuff where they are! ",
  hate_statue_message: "you think you're tidying up but are in fact just hiddin stuff!"
)

puts "...5 days ago"

Statue.create(
  mood_category: (MoodCategory.all[1]),
  user: user1,
  start_date: Time.now - (86_400 * 5),
  main_statue_message: "Not so happy",
  love_statue_message: "you can leave my stuff where they are! ",
  hate_statue_message: "you think you're tidying up but are in fact just hiddin stuff!"
)

puts "...3 days ago"

Statue.create(
  mood_category: (MoodCategory.all[3]),
  user: user1,
  start_date: Time.now - (86_400 * 3),
  main_statue_message: "Life is good!",
  love_statue_message: "I could spend the week-end with my homies",
  hate_statue_message: "it's soccer game night and you make me watch The f**ing notebook! "
)

puts "...yesterday"

Statue.create(
  mood_category: (MoodCategory.all[2]),
  user: user1,
  start_date: Time.now - 86_400,
  main_statue_message: "Still the same story",
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

puts "status created for user 1"

#---------------------------Status_User4----------------------------------------
puts "Creating status for user4"
puts "...7 days ago"
Statue.create(
  mood_category: MoodCategory.all[0],
  user: user4,
  start_date: Time.now - (86_400 * 7),
  main_statue_message: "You drive me f**in' maad!",
  love_statue_message: "you can leave my stuff where they are! ",
  hate_statue_message: "you think you're tidying up but are in fact just hiddin stuff!"
)

puts "...4 days ago"

Statue.create(
  mood_category: MoodCategory.all[1],
  user: user4,
  start_date: Time.now - (85_400 * 4),
  main_statue_message: "Not so happy",
  love_statue_message: "you can leave my stuff where they are! ",
  hate_statue_message: "you think you're tidying up but are in fact just hiddin stuff!"

)

puts "...3 days ago"

Statue.create(
  mood_category: MoodCategory.all[2],
  user: user4,
  start_date: Time.now - (85_400 * 3),
  main_statue_message: "So so",
  love_statue_message: "you can leave my stuff where they are! ",
  hate_statue_message: "you think you're tidying up but are in fact just hiddin stuff!"

)

puts "...2 days ago"

Statue.create(
  mood_category: MoodCategory.all[3],
  user: user4,
  start_date: Time.now - (85_400 * 2),
  main_statue_message: "Life is good!",
  love_statue_message: "I could spend the week-end with my homies",
  hate_statue_message: "it's soccer game night and you make me watch The f**ing notebook! "
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
  start_date: Time.now - (85_400 * 7),
  main_statue_message: "Don't even talk to me!",
  love_statue_message: "you clean up your mess!",
  hate_statue_message: "you come back completely drunk at 5am and throw up in the bed!"
)

puts "...6 days ago"

Statue.create(
  mood_category: (MoodCategory.all[1]),
  user: user3,
  start_date: Time.now - (85_400 * 6),
  main_statue_message: "You better have a good reason for not returning my calls!",
  love_statue_message: "you prepare a nice dinner tonight",
  hate_statue_message: "you do not recall my call!"
)

puts "...3 days ago"

Statue.create(
  mood_category: (MoodCategory.all[2]),
  user: user3,
  start_date: Time.now - (85_400 * 3),
  main_statue_message: "You're so annoying!",
  love_statue_message: "you apologize and make it up to me!",
  hate_statue_message: "you forget my birthday!"

)

puts "...2 days ago"

Statue.create(
  mood_category: (MoodCategory.all[0]),
  user: user3,
  start_date: Time.now - (85_400 * 2),
  main_statue_message: "Don't even talk to me!",
  love_statue_message: "you clean up your mess! ",
  hate_statue_message: "you come back completely drunk at 5am and throw up in the bed!"

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
  title: "Dog Out",
  description: "The dogs should take a walk to keep the flat clean.",
  base_score: 30,
  couple: couple1,
  emoji: "🦮"
)

GenericTask.create(
  title: "Dishwashing",
  description: "Keeping the kitchen clean is a good medicine.",
  base_score: 40,
  couple: couple1,
  emoji: "🧤"
)

GenericTask.create(
  title: "Ironing",
  description: "A little ironing to have presentable outfits.",
  base_score: 25,
  couple: couple1,
  emoji: "♨️"
)

GenericTask.create(
  title: "Cleaning",
  description: "Basic hygiene for a better life.",
  base_score: 60,
  couple: couple1,
  emoji: "🧽"
)

GenericTask.create(
  title: "Cooking",
  description: "Cook some good food.",
  base_score: 50,
  couple: couple1,
  emoji: "🍽️"
)

GenericTask.create(
  title: "Prepare the dinner",
  description: "Cook some good food.",
  base_score: 50,
  couple: couple2,
  emoji: "🍽️"
)

GenericTask.create(
  title: "Vacuum",
  description: "Keep the house tidy with some vacuum cleaning.",
  base_score: 15,
  couple: couple2,
  emoji: "🧹"
)

GenericTask.create(
  title: "Prepare the dinner",
  description: "Cook some good food.",
  base_score: 50,
  couple: couple2,
  emoji: "🍽️"
)

GenericTask.create(
  title: "Wash and hang clothes",
  description: "Taking showers is not enough, our clothes also have to smell good.",
  base_score: 35,
  couple: couple2,
  emoji: "🧥"
)

GenericTask.create(
  title: "Change the bedding",
  description: "A fresh bed for a deep sleep.",
  base_score: 30,
  couple: couple2,
  emoji: "🛏️"
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
  date: Date.parse("05/03/2024"),
  base_score: 15,
  user: user2,
  status: "pending",
  assigned_to: "Loulou",
  emoji: "🐟"
)

Task.create(
  title: "Water the plants",
  description: "Our plants look rather dry.",
  date: Date.parse("03/03/2024"),
  base_score: 15,
  user: user2,
  status: "pending",
  assigned_to: "any",
  emoji: "🪴"
)

Task.create(
  title: "Book spring holidays",
  description: "Time flies. Please take some time to book our next holidays.",
  date: Date.parse("15/03/2024"),
  base_score: 70,
  user: user2,
  status: "pending",
  assigned_to: "Loulou",
  emoji: "🗻"
)

Task.create(
  title: "Clean the carpet",
  description: "There is dust all over the carpet. It pisses me off.",
  date: Date.parse("04/03/2024"),
  base_score: 15,
  user: user2,
  status: "pending",
  assigned_to: "any",
  emoji: "🧹"
)

Task.create(
  title: "Buy a gift for my nephew",
  description: "I think he likes video games.",
  date: Date.parse("15/03/2024"),
  base_score: 50,
  user: user4,
  status: "pending",
  assigned_to: "Kim",
  emoji: "🎁"
)

Task.create(
  title: "Order some wine for Christmas",
  description: "Please take some quality wine this time. I don't like piss.",
  date: Date.parse("16/03/2024"),
  base_score: 40,
  user: user3,
  status: "pending",
  assigned_to: "Kim",
  emoji: "🍷"
)

Task.create(
  title: "Take my dress to the dry cleaning",
  description: "There are some blemishes on my dress I would like to get rid of.",
  date: Date.parse("09/03/2024"),
  base_score: 25,
  user: user3,
  status: "pending",
  assigned_to: "Ye",
  emoji: "👗"
)

Task.create(
  title: "Grocery list",
  description: "We ran out of pasta.",
  date: Date.parse("06/03/2024"),
  base_score: 25,
  user: user1,
  status: "pending",
  assigned_to: "any",
  emoji: "🏪"
)

Task.create(
  title: "Fix the cupboard",
  description: "I can't stand this defective cupboard anymore. Do something.",
  date: Date.parse("07/03/2024"),
  base_score: 30,
  user: user3,
  status: "pending",
  assigned_to: "Ye",
  emoji: "🗄️"
)

Task.create(
  title: "Send back my headphones for refund",
  description: "This garbage does not work.",
  date: Date.parse("08/03/2024"),
  base_score: 25,
  user: user4,
  status: "pending",
  assigned_to: "any",
  emoji: "🎧"
)

Task.create(
  title: "Buy some painkillers at the drugstore",
  description: "My back hurts.",
  date: Date.parse("05/03/2024"),
  base_score: 25,
  user: user4,
  status: "pending",
  assigned_to: "any",
  emoji: "💊"
)

Task.create(
  title: "Change the bedding",
  description: "A fresh bed for a deep sleep.",
  date: Date.parse("08/03/2024"),
  base_score: 30,
  user: user1,
  status: "pending",
  assigned_to: "any",
  emoji: "🛏️"
)

Task.create(
  title: "Do the dishes",
  description: "Keeping the kitchen clean is a good medicine.",
  date: Date.parse("09-03-2024"),
  base_score: 40,
  user: user2,
  status: "pending",
  assigned_to: "any",
  emoji: "🧤"
)

# Ajout de tasks JM : ci-dessous------------------------------------------------
# Semaine 1---------------------------------------------------------------------
puts "Tasks Couple 1 Week 1 (Seed Jerem)"
Task.create(
  title: "Dishwashing",
  description: "Keeping the kitchen clean is a good medicine.",
  date: Date.today - 28,
  base_score: 40,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🧤",
  done_by: user1.nickname
)
Task.create(
  title: "Ironing",
  description: "A little ironing to have presentable outfits.",
  date: Date.today - 26,
  base_score: 25,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "♨️",
  done_by: user2.nickname
)
Task.create(
  title: "Cleaning",
  description: "Basic hygiene for a better life.",
  date: Date.today - 24,
  base_score: 60,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🧽",
  done_by: user2.nickname
)
Task.create(
  title: "Cooking",
  description: "Basic hygiene for a better life.",
  date: Date.today - 23,
  base_score: 60,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🍽️",
  done_by: user2.nickname
)
Task.create(
  title: "Dog out",
  description: "The dogs should take a walk to keep the flat clean.",
  date: Date.today - 22,
  base_score: 30,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🦮",
  done_by: user2.nickname
)
# Semaine 2---------------------------------------------------------------------
puts "Tasks Couple 1 Week 2 (Seed Jerem)"
Task.create(
  title: "Dishwashing",
  description: "Keeping the kitchen clean is a good medicine.",
  date: Date.today - 20,
  base_score: 40,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🧤",
  done_by: user2.nickname
)
Task.create(
  title: "Ironing",
  description: "A little ironing to have presentable outfits.",
  date: Date.today - 18,
  base_score: 25,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "♨️",
  done_by: user1.nickname
)
Task.create(
  title: "Cleaning",
  description: "Basic hygiene for a better life.",
  date: Date.today - 17,
  base_score: 60,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🧽",
  done_by: user2.nickname
)
Task.create(
  title: "Cooking",
  description: "Basic hygiene for a better life.",
  date: Date.today - 16,
  base_score: 60,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🍽️",
  done_by: user2.nickname
)
Task.create(
  title: "Dog out",
  description: "The dogs should take a walk to keep the flat clean.",
  date: Date.today - 15,
  base_score: 30,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🦮",
  done_by: user1.nickname
)
# Semaine 3---------------------------------------------------------------------
puts "Tasks Couple 1 Week 3 (Seed Jerem)"
Task.create(
  title: "Dishwashing",
  description: "Keeping the kitchen clean is a good medicine.",
  date: Date.today - 13,
  base_score: 40,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🧤",
  done_by: user2.nickname
)
Task.create(
  title: "Ironing",
  description: "A little ironing to have presentable outfits.",
  date: Date.today - 12,
  base_score: 25,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "♨️",
  done_by: user2.nickname
)
demo_task = Task.create(
  title: "Cleaning",
  description: "Basic hygiene for a better life.",
  date: Date.today - 10,
  base_score: 60,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🧽",
  done_by: user1.nickname
)

demo_task.photos.attach(io: URI.open("https://as1.ftcdn.net/v2/jpg/04/18/51/22/1000_F_418512250_dGHkhlcXL4y83pT4oH3rwkzPUEqEKGIo.jpg"),
                       filename: "demo.jpg", content_type: "image/jpg")

Task.create(
  title: "Cooking",
  description: "Basic hygiene for a better life.",
  date: Date.today - 9,
  base_score: 60,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🍽️",
  done_by: user2.nickname
)
Task.create(
  title: "Dog out",
  description: "The dogs should take a walk to keep the flat clean.",
  date: Date.today - 8,
  base_score: 30,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🦮",
  done_by: user1.nickname
)
# Semaine 4---------------------------------------------------------------------
puts "Tasks Couple 1 Week 4 (Seed Jerem)"
Task.create(
  title: "Dishwashing",
  description: "Keeping the kitchen clean is a good medicine.",
  date: Date.today - 6,
  base_score: 40,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🧤",
  done_by: user2.nickname
)
Task.create(
  title: "Ironing",
  description: "A little ironing to have presentable outfits.",
  date: Date.today - 5,
  base_score: 25,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "♨️",
  done_by: user2.nickname
)
Task.create(
  title: "Cleaning",
  description: "Basic hygiene for a better life.",
  date: Date.today - 3,
  base_score: 60,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🧽",
  done_by: user2.nickname
)
Task.create(
  title: "Cooking",
  description: "Basic hygiene for a better life.",
  date: Date.today - 2,
  base_score: 60,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🍽️",
  done_by: user1.nickname
)
Task.create(
  title: "Dog out",
  description: "The dogs should take a walk to keep the flat clean.",
  date: Date.today - 1,
  base_score: 30,
  user: user2,
  status: "done",
  assigned_to: "any",
  emoji: "🦮",
  done_by: user1.nickname
)
# Ajout de tasks JM : ci-dessus-------------------------------------------------
puts "Task instances created."

GenericReward.create!(
  title: 'Movie Night',
  description: 'Enjoy a movie night together.',
  cost: 50,
  couple: couple1,
  emoji: "🎥"
)
GenericReward.create!(
  title: 'Dinner Date',
  description: 'Have a romantic dinner at your favorite restaurant.',
  cost: 80,
  couple: couple1,
  emoji: "🥂"
)
GenericReward.create!(
  title: 'Weekend Getaway',
  description: 'Plan a weekend getaway to relax and unwind.',
  cost: 150,
  couple: couple1,
  emoji: "✈️"
)

GenericReward.create!(
  title: 'Ayurvedic massage',
  description: 'Give me a long oily massage',
  cost: 50,
  couple: couple2,
  emoji: "🤲"
)

GenericReward.create!(
  title: 'Football night with my crew',
  description: 'Let me have my friends over, watch football, drink beer and be real duuudes.',
  cost: 75,
  couple: couple1,
  emoji: "⚽​"
)

GenericReward.create!(
  title: 'Skip in-laws dinner',
  description: 'Let me pretend I am sick next time we are invited at your parents.',
  cost: 50,
  couple: couple1,
  emoji: "🤮​​"
)

GenericReward.create!(
  title: 'Sexual fantasy',
  description: 'I would love that you sit on my face and spank me',
  cost: 100,
  couple: couple1,
  emoji: "🌶️"
)

GenericReward.create!(
  title: 'Make the brunch',
  description: 'Make a huge brunch for us to enjoy together.',
  cost: 50,
  couple: couple2,
  emoji: "⭐"
)

GenericReward.create!(
  title: 'Buy me a gift',
  description: 'Surprise me',
  cost: 100,
  couple: couple2,
  emoji: "🎁"
  )

Reward.create!(
  date: "08/01/2024",
  user: user2,
  status: 'done',
  description: 'A nice bouquet of flowers',
  title: 'Bouquet of flowers',
  cost: 100,
  emoji: "💐"
)

Reward.create!(
  date: "26/01/2024",
  user: user2,
  status: 'done',
  description: 'A box of delicious chocolates',
  title: 'Box of chocolates',
  cost: 100,
  emoji: "🍫"
)

Reward.create!(
  date: "11/02/2024",
  user: user1,
  status: 'done',
  description: 'Pancakes forever',
  title: 'Cook my favorite breakfast',
  cost: 75,
  emoji: "🥞"
)

Reward.create!(
  date: "16/02/2024",
  user: user1,
  status: 'done',
  description: 'Let\'s party',
  title: 'Let\'s dance tonight',
  cost: 80,
  emoji: "🪩"
)
# Ajout de tasks JM : ci-dessous------------------------------------------------
# Semaine 1---------------------------------------------------------------------
puts "Rewards Couple 1 Week 1 (Seed Jerem)"
Reward.create!(
  date: Date.today - 24,
  user: user2,
  status: 'done',
  description: 'Give me a long oily massage',
  title: 'Ayurvedic massage',
  cost: 50,
  emoji: "😍"
)
Reward.create!(
  date: Date.today - 20,
  user: user2,
  status: 'done',
  description: 'Plan a weekend getaway to relax and unwind.',
  title: 'Weekend Getaway',
  cost: 150,
  emoji: "✈️"
)
# Semaine 2---------------------------------------------------------------------
puts "Rewards Couple 1 Week 2 (Seed Jerem)"
Reward.create!(
  date: Date.today - 18,
  user: user2,
  status: 'done',
  description: 'Enjoy a movie night together.',
  title: 'Movie Night',
  cost: 50,
  emoji: "🎥"
)
Reward.create!(
  date: Date.today - 16,
  user: user2,
  status: 'done',
  description: 'Have a romantic dinner at your favorite restaurant.',
  title: 'Dinner Date',
  cost: 80,
  emoji: "🥂"
)
# Semaine 3---------------------------------------------------------------------
puts "Rewards Couple 1 Week 3 (Seed Jerem)"
Reward.create!(
  date: Date.today - 13,
  user: user2,
  status: 'done',
  description: 'Give me a long oily massage',
  title: 'Massage Ayurvedique',
  cost: 50,
  emoji: "😍"
)
Reward.create!(
  date: Date.today - 10,
  user: user2,
  status: 'done',
  description: 'Plan a weekend getaway to relax and unwind.',
  title: 'Weekend Getaway',
  cost: 150,
  emoji: "✈️"
)
# Semaine 4---------------------------------------------------------------------
puts "Rewards Couple 1 Week 4 (Seed Jerem)"
Reward.create!(
  date: Date.today - 6,
  user: user1,
  status: 'done',
  description: 'Let me have my friends over, watch football, drink beer and be real duuudes.',
  title: 'Football night with my crew',
  cost: 75,
  emoji: "⚽​"
)
Reward.create!(
  date: Date.today - 5,
  user: user2,
  status: 'done',
  description: 'Give me a long oily massage',
  title: 'Ayurvedic massage',
  cost: 50,
  emoji: "😍"
)
Reward.create!(
  date: Date.today - 4,
  user: user2,
  status: 'done',
  description: 'Have a romantic dinner at your favorite restaurant.',
  title: 'Dinner Date',
  cost: 80,
  emoji: "🥂"
)
Reward.create!(
  date: Date.today - 2,
  user: user1,
  status: 'done',
  description: 'Let me pretend I am sick next time we are invited at your parents.',
  title: 'Skip in-laws dinner',
  cost: 50,
  emoji: "🤮"
)


puts 'Seed data for rewards created successfully!'
