class Review < ApplicationRecord
  has_many :review_comments
  has_many :review_favorites
  has_many :review_facility_categories
  belongs_to :user
end
