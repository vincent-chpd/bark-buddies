class Event < ApplicationRecord
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_location,
    against: [ :location],
    using: {
      tsearch: { prefix: true }
    }
end
