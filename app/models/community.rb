class Community < ApplicationRecord
  has_one_attached :photo
  has_many :community_messages, dependent: :destroy
end
