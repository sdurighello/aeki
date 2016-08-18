class Product < ApplicationRecord
  has_one :inventory
  has_many :line_items
  accepts_nested_attributes_for :inventory, :allow_destroy => true

  validates :name, presence: true
  validates :name, uniqueness: true

  validates :description, presence: true

  validates :image, presence: true

  validates :price, presence: true

  mount_uploader :image, ImageUploader



end
