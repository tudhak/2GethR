class Reward < ApplicationRecord
  belongs_to :user

  validates :date, :title, :description, :cost, presence: true

  def start_time
    self.date
  end
end
