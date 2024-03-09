class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :dogs, dependent: :destroy
  has_many :conversations, foreign_key: :sender_id, dependent: :destroy
end
