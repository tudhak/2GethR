# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Destroying status..."
Statue.destroy_all

puts "Destroying mood categories..."
MoodCategory.destroy_all

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
  last_name: 'Dujardin',
  first_name: 'Jean',
  nickname: 'Loulou',
  date_of_birth: Date.parse('1990-01-01'),
  score: 100,
  mode: 'normal',
  couple: couple1
)

user2 = User.create(
  email: 'user2@example.com',
  password: 'password456',
  last_name: 'Lamy',
  first_name: 'Alexandra',
  nickname: 'chouchou',
  date_of_birth: Date.parse('1992-03-15'),
  score: 120,
  mode: 'normal',
  couple: couple1
)

user3 = User.create(
  email: 'user3@example.com',
  password: 'password123',
  last_name: 'Kardashian',
  first_name: 'Kimberly',
  nickname: 'Kim',
  date_of_birth: Date.parse('1980-10-21'),
  score: 80,
  mode: 'normal',
  couple: couple2
)

user4 = User.create(
  email: 'user4@example.com',
  password: 'password345',
  last_name: 'West',
  first_name: 'Kanye',
  nickname: 'Ye',
  date_of_birth: Date.parse('1977-06-08'),
  score: 120,
  mode: 'normal',
  couple: couple2
)
puts "Users created"

puts "Creating task templates (generic tasks)..."

puts "Task templates created."

#------------------------------Mood Categories----------------------------------
puts "Creating Mood Categories"

mood_cat = [
  {title: "stormy", url: "https://w0.peakpx.com/wallpaper/1010/238/HD-wallpaper-into-the-storm-lightning-thunder-strike-thumbnail.jpg"},
  {title: "rainy", url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLuW0GIlrYKhIzynv9ITRKUnVzFvDkD5LU9Q&usqp=CAU"},
  {title: "cloudy", url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBeFuUS1xlGXN994FpFwVLhmZgUhEIfl8FDg&usqp=CAU"},
  {title: "sunny", url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGv6foDhUwklEvERo1MuHykzepVY8cc64ipQ&usqp=CAU"}
]

mood_cat.each { |mood| MoodCategory.create(title: mood[:title], image_path: mood[:url]) }

puts "Four Categories created"
#------------------------------Status-------------------------------------------
puts "Creating status for user4"
puts "...day1"
u4_status1 = Statue.create(
  mood_category_id: MoodCategory.first.id,
  user: user4
)
sleep(5)
puts "...day2"
u4_status2 = Statue.create(
  mood_category_id: (MoodCategory.first.id + 1),
  user: user4
)
u4_status1.end_date = u4_status2.created_at
u4_status1.save

sleep(5)
puts "...day3"
u4_status3 = Statue.create(
  mood_category_id: (MoodCategory.first.id + 2),
  user: user4
)
u4_status2.end_date = u4_status3.created_at
u4_status2.save

sleep(5)
puts "...day4"
u4_status4 = Statue.create(
  mood_category_id: (MoodCategory.first.id + 3),
  user: user4
)
u4_status3.end_date = u4_status4.created_at
u4_status3.save

puts "4 status created for user 4"

#-------------------------------------------------------------------------------
