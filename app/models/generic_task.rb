class GenericTask < ApplicationRecord
  has_many_attached :photos
  belongs_to :couple

  validates :title, :description, :base_score, presence: true
end
