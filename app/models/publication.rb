class Publication < ApplicationRecord
  has_many :publication_users
  has_many :users, through: :publication_users
end

  