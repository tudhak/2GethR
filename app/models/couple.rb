class Couple < ApplicationRecord
  has_many :users, :messages
end
