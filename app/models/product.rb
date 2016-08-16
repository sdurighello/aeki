class Product < ApplicationRecord
  belongs_to :inventory
  has_many :line_items
end
