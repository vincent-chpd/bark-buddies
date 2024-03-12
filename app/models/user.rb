class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :dogs, dependent: :destroy
  has_many :conversations, foreign_key: :sender_id, dependent: :destroy
<<<<<<< HEAD
  has_many :messages, through: :conversations
=======
  has_many :community_messages, dependent: :destroy
>>>>>>> 8f93d24383d5e13e7efffb091e6ad075b235cb1f

  include PgSearch::Model
  pg_search_scope :search_by_location_name,
    against: [ :name, :location ],
    using: {
      tsearch: { prefix: true }
  }
end
