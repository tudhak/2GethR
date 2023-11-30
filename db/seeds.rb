# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Destroying users..."
User.destroy_all

puts "Destroying couples..."
Couple.destroy_all

puts "Destroying task templates (generic tasks)..."
GenericTask.destroy_all

puts "Destroying task instances (tasks)..."
Task.destroy_all

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
  couple: couple1,
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

puts "Creating task templates (generic tasks)..."
GenericTask.create(
  title: "Let the dogs out",
  description: "The dogs should take a walk to keep the flat clean.",
  base_score: 30
)

GenericTask.create(
  title: "Do the dishes",
  description: "Keeping the kitchen clean is a good medicine.",
  base_score: 40
)

GenericTask.create(
  title: "Iron clothes",
  description: "A little ironing to have presentable outfits.",
  base_score: 25
)

GenericTask.create(
  title: "Full house cleaning",
  description: "Basic hygiene for a better life.",
  base_score: 60
)

GenericTask.create(
  title: "Vacuum",
  description: "Keep the house tidy with some vacuum cleaning.",
  base_score: 15
)

GenericTask.create(
  title: "Prepare the dinner",
  description: "Cook some good food.",
  base_score: 50
)

GenericTask.create(
  title: "Wash and hang clothes",
  description: "Taking showers is not enough, our clothes also have to smell good.",
  base_score: 35
)

GenericTask.create(
  title: "Change the bedding",
  description: "A fresh bed for a deep sleep.",
  base_score: 30
)
puts "Task templates created."

puts "Creating task instances (tasks)..."
Task.create(
  title: "Feed the fishes",
  description: "Feed our lovely fishes with adapted pet food.",
  date: Date.parse("30/11/2023").strftime('%B %d, %Y'),
  base_score: 15,
  user: user2,
  statue: "pending",
  assigned_to: "Loulou"
)

Task.create(
  title: "Water the plants",
  description: "Our plants look rather dry.",
  date: Date.parse("01/12/2023").strftime('%B %d, %Y'),
  base_score: 15,
  user: user2,
  statue: "pending",
  assigned_to: "any"
)

Task.create(
  title: "Book winter holidays",
  description: "Time flies. Please take some time to book our next holidays.",
  date: Date.parse("30/11/2023").strftime('%B %d, %Y'),
  base_score: 70,
  user: user2,
  statue: "pending",
  assigned_to: "Loulou"
)

Task.create(
  title: "Clean the carpet",
  description: "There is dust all over the carpet. It pisses me off.",
  date: Date.parse("06/12/2023").strftime('%B %d, %Y'),
  base_score: 15,
  user: user2,
  statue: "pending",
  assigned_to: "any"
)

Task.create(
  title: "Buy a gift for my nephew",
  description: "I think he likes video games.",
  date: Date.parse("15/12/2023").strftime('%B %d, %Y'),
  base_score: 50,
  user: user4,
  statue: "pending",
  assigned_to: "Kim"
)

Task.create(
  title: "Order some wine for Christmas",
  description: "Please take some quality wine this time. I don't like piss.",
  date: Date.parse("16/12/2023").strftime('%B %d, %Y'),
  base_score: 40,
  user: user3,
  statue: "pending",
  assigned_to: "Kim"
)

Task.create(
  title: "Take my dress to the dry cleaning",
  description: "There are some blemishes on my dress I would like to get rid of.",
  date: Date.parse("09/12/2023").strftime('%B %d, %Y'),
  base_score: 25,
  user: user3,
  statue: "pending",
  assigned_to: "Ye"
)

Task.create(
  title: "Go to the grocery store",
  description: "We ran out of pasta.",
  date: Date.parse("12/12/2023").strftime('%B %d, %Y'),
  base_score: 25,
  user: user1,
  statue: "pending",
  assigned_to: "any"
)

Task.create(
  title: "Fix the cupboard",
  description: "I can't stand this defective cupboard anymore. Do something.",
  date: Date.parse("07/12/2023").strftime('%B %d, %Y'),
  base_score: 30,
  user: user3,
  statue: "pending",
  assigned_to: "Ye"
)

Task.create(
  title: "Send back my headphones for refund",
  description: "This garbage does not work.",
  date: Date.parse("08/12/2023").strftime('%B %d, %Y'),
  base_score: 25,
  user: user4,
  statue: "pending",
  assigned_to: "any"
)

Task.create(
  title: "Buy some painkillers at the drugstore",
  description: "My back hurts.",
  date: Date.parse("02/12/2023").strftime('%B %d, %Y'),
  base_score: 25,
  user: user4,
  statue: "pending",
  assigned_to: "any"
)

Task.create(
  title: "Change the bedding",
  description: "A fresh bed for a deep sleep.",
  date: Date.parse("03/12/2023").strftime('%B %d, %Y'),
  base_score: 30,
  user: user1,
  statue: "pending",
  assigned_to: "any"
)

Task.create(
  title: "Do the dishes",
  description: "Keeping the kitchen clean is a good medicine.",
  date: Date.parse("01-12-2023").strftime('%B %d, %Y'),
  base_score: 40,
  user: user2,
  statue: "pending",
  assigned_to: "any"
)

puts "Task instances created."
