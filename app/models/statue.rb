class Statue < ApplicationRecord
  belongs_to :mood_category
  belongs_to :user
end
