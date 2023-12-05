class Task < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  validates :date, :base_score, :title, :description, :assigned_to, presence: true

  def start_time
    self.date
  end
end
