class AddProductToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :line_items, :product, foreign_key: true
  end
end
