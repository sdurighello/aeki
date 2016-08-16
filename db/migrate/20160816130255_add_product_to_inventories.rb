class AddProductToInventories < ActiveRecord::Migration[5.0]
  def change
    add_reference :inventories, :product, foreign_key: true
  end
end
