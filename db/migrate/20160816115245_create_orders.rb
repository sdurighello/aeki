class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :payment_id
      t.boolean :paid
      t.timestamps
    end
  end
end
