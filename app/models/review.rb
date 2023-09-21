class Review < ApplicationRecord
  has_many :review_comments
  has_many :review_favorites
  has_many :review_facility_categories
  has_many :facility_categories, through: :review_facility_categories
  belongs_to :user

  has_many_attached :image

  validates :facility_name, presence: true
  validates :text, presence: true
  validates :rating, presence: true
  validates :post_code, presence: true
  validates :address, presence: true
  validates :image, presence: true


  def favorited_by?(user)
      review_favorites.exists?(user_id: user.id)
  end

  #addressの文字列から自動で緯度と経度のカラムに値を代入
  geocoded_by :address
  #addressカラムが値が代入される時（createとupdate）に、緯度と経度を住所から変換
  after_validation :geocode, if: :address_changed?

end
