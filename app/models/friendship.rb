class Friendship < ApplicationRecord
  has_one :receiver, class_name: "User"
  has_one :sender, class_name: "User"
end
