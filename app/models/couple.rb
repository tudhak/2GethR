class Couple < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :generic_tasks, dependent: :destroy
  has_many :generic_rewards, dependent: :destroy
end
