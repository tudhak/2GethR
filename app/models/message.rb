class Message < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :couple

  def sender?(a_user)
    user.id == a_user.id
  end
end
