class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def product_name
    Product.where(id: self.product).name
  end
end
