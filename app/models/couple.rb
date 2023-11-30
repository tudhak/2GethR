class Couple < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :messages, dependent: :destroy
end
