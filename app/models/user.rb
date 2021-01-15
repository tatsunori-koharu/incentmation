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
  has_many :article_comments, dependent: :destroy
  has_many :article_likes, through: :articles, dependent: :destroy, source: :post
  has_many :consultations
  has_many :consultation_comments, dependent: :destroy
  has_many :consultation_fixes, through: :consultation_fixes, dependent: :destroy, source: :post
  has_many :promotions
  has_many :promotion_comments, dependent: :destroy
  has_many :promotion_likes, through: :promotions, dependent: :destroy, source: :post
  has_many :user_chats
  has_many :chats, through: :user_chats
  has_many :chat_messages
  has_many :donkeykings
  has_one_attached :image


  with_options presence: true do
    validates :nickname, uniqueness: true
    validates :email, uniqueness: true
    validates :password, on: :create
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

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def self.guest
    find_or_create_by!(email: 'ooo@ooo.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.nickname = 'ゲストユーザー'
      user.location_id = 28
      user.department_id = 3
      user.bed = 333
      user.service_years = 20
      user.license = "看護士"
    end
  end


end
