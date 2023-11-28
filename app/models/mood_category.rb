class MoodCategory < ApplicationRecord
  has_many :statues, dependent: :destroy
  has_many_attached :photos
end
