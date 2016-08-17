class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :surname
      t.string :addr_street
      t.string :addr_postcode
      t.string :addr_town
      t.string :gender

      t.timestamps
    end
  end
end
