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
         :recoverable, :rememberable, :validatable, password_length: 10..128

  # The built-in email validation regexp below is not bulletproof, but no regexp is
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Please enter a valid email" }

  validates :date_of_birth, comparison: { greater_than: Date.new(1940, 12, 31), less_than: Date.new(2006, 12, 31), message: "invalid." }

  validates :last_name, :first_name, :nickname, presence: true

  validate :password_complexity

  before_create :default_points

  private

  def default_points
    self.score = 0
  end

  def password_complexity
    # Think about using a dedicated third-party solution for password validation
    # Such as https://github.com/bdmac/strong_password or
    # devise security extension https://github.com/devise-security/devise-security
    return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/

    errors.add :password, 'Complexity requirement not met. Please use: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

end
