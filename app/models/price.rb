class Price < ApplicationRecord
  validates :item, :price, :unit, :month, presence: true
  validates :price, numericality: { greater_than: 0 }
  
  scope :for_item, ->(item) { where(item: item) }
  scope :for_month, ->(month) { where(month: month) }
end