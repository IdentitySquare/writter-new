class Comment < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :post

  # validations
  validates :body, length: { maximum: 1000, message: "is too long (maximum is 1000 characters)" }
end
