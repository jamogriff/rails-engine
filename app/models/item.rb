class Item < ApplicationRecord
  belongs_to :merchant

  # This dependent destroy clause wouldn't work in a
  # production environment, since it would delete all previous 
  # invoice items that are associated with it
  has_many :invoice_items, dependent: :destroy

  # I assume records can't be updated/created without
  # a merchant association, but I may be wrong
  validates_presence_of :name, :description, :unit_price
  validates_numericality_of :unit_price


  def self.find_all(search_params)
    Item.where("name ILIKE '%#{search_params}%'")
  end
end
