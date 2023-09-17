class Review < ApplicationRecord
  has_many :review_comments
  has_many :review_favorites
  #has_many :users, throguh: :review_favorites
  has_many :review_facility_categories
  has_many :facility_categories, through: :review_facility_categories
  belongs_to :user

  has_many_attached :image

  validates :text, presence: true


  def favorited_by?(user)
      review_favorites.exists?(user_id: user.id)
  end

end
