class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers: [:facebook, :google_oauth2]

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :location
  belongs_to :department
  has_many :sns_credentials
end
