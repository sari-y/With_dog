class FacilityCategory < ApplicationRecord
  has_many :review_facility_categories, dependent: :destroy
  has_many :reviews, through: :review_facility_categories
end
