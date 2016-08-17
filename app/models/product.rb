class Product < ApplicationRecord
  belongs_to :inventory
  has_many :line_items

  validates :name, presence: true
  validates :name, uniqueness: true

  validates :description, presence: true

  validates :image, presence: true

  validates :price, presence: true

  mount_uploader :image, ImageUploader
end
