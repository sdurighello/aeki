class Inventory < ApplicationRecord
  has_many :products
  
  # Availability check for a product
  def is_product_available? (product_id)
    inventory_line = self.find_by(product_id: product_id)
    if inventory_line && (inventory_line.quantity > 0)
      true
    else
      false
    end
  end


end
