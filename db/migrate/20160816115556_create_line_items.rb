class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.decimal12 :price
      t.decimal2 :price
      t.integer :quantity

      t.timestamps
    end
  end
end
