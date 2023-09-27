class ReviewFacilityCategory < ApplicationRecord
  belongs_to :review
  belongs_to :facility_category
end
