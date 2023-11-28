class MoodCategory < ApplicationRecord
  has_many :statues
  has_many_attached :photos
end
