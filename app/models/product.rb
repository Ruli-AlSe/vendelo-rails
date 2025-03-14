class Product < ApplicationRecord
  ORDER_BY = {
    "newest" => "created_at DESC",
    "expensive" => "price DESC",
    "cheapest" => "price ASC"
  }

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true

  has_one_attached :photo
  belongs_to :category
  # This is the other way to assing products to the current logged user
  belongs_to :user, default: -> { Current.user }
end
