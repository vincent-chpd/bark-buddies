class Event < ApplicationRecord
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_title,
    against: [ :title],
    using: {
      tsearch: { prefix: true }
    }
end
