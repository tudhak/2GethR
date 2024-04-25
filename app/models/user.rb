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

  validates :email, :nickname, presence: true, uniqueness: true
  validates :last_name, :first_name, :date_of_birth, presence: true

  # TODO: Remplacer les variables @partner par la méthode user.mate ?
  def mate
    couple.users.find { |u| u.id != id }
  end
end
