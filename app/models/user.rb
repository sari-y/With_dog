class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, :dependent => :destroy
  has_many :review_comments, :dependent => :destroy
  has_many :review_favorites, :dependent => :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  has_one_attached :profile_image

  GUEST_USER_EMAIL = "guest@example.com"

  def get_profile_image(width=150,hight=150) # 画像サイズの指定がなければ150x150
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    # 画像の大きさを統一する処理（小さい画像は拡大して表示される）
    profile_image.variant(resize: "#{width}x#{hight}^", gravity: "center", crop: "#{width}x#{hight}+0+0").processed
  end


  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

end
