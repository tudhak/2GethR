class GenericTask < ApplicationRecord
  has_many_attached :photos
  belongs_to :couple
end
