class Community < ApplicationRecord
  has_one_attached :photo
  has_many :community_messages, dependent: :destroy
  has_many :users

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name, :description ],
    using: {
      tsearch: { prefix: true }
    }
end
