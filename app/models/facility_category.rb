class FacilityCategory < ApplicationRecord
  has_many :review_facility_categories
  has_many :reviews, through: :review_facility_categories
end
