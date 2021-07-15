class Item < ApplicationRecord
  belongs_to :merchant

  # I assume records can't be updated/created without
  # a merchant association, but I may be wrong
  validates_presence_of :name, :description, :unit_price
  validates_numericality_of :unit_price
end
