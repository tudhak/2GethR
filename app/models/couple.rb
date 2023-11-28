class Couple < ApplicationRecord
  has_many :users, :messages
  # has_many :messages
end
