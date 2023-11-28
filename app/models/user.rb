class User < ApplicationRecord
  # belongs_to :couple
  # has_many :statues
  # has_many :rewards
  # has_many :tasks
  # has_many :messages
  # has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
