class Product < ApplicationRecord
  include Favoritable
  ORDER_BY = {
    newest: "created_at DESC",
    expensive: "price DESC",
    cheapest: "price ASC"
  }

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true

  has_one_attached :photo
  belongs_to :category
  # This is the other way to assing products to the current logged user
  belongs_to :user, default: -> { Current.user }

  def owner?
    user_id == Current.user&.id
  end

  def broadcast
    broadcast_replace_to self, partial: "products/product_details", locals: { product: self }
  end
end
