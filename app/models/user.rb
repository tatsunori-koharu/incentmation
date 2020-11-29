class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :location
  belongs_to :department
  has_many :sns_credentials
  has_many :articles
  has_many :article_comments
  has_many :article_likes, through: :articles, dependent: :destroy, source: :post
  has_many :consultations
  has_many :consultation_comments
  has_many :consultation_fixes, through: :consultation_fixes, dependent: :destroy, source: :post
  has_many :promotions

  with_options presence: true do
    validates :nickname, uniqueness: true
    validates :email, uniqueness: true
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
    validates :service_years, format: { with: /\A[0-9]+\z/ }
  end
  with_options numericality: { other_than: 1 } do
    validates :location_id
  end

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
