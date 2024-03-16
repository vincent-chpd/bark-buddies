class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :dogs, dependent: :destroy
  has_many :conversations, foreign_key: :sender_id, dependent: :destroy
  has_many :community_messages, dependent: :destroy
  has_many :sent_friendships, class_name: "Friendship", foreign_key: :sender_id, dependent: :destroy
  has_many :received_friendships, class_name: "Friendship", foreign_key: :receiver_id, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_by_location_name,
    against: [ :name, :location ],
    using: {
      tsearch: { prefix: true }
  }
end
