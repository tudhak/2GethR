class User < ApplicationRecord
  belongs_to :couple
  has_many :statues, dependent: :destroy
  has_many :rewards, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one_attached :photo

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def mate
    couple.users.find { |u| u.id != id }
  end

end
