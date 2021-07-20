class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def self.find_by_name(search_params)
    Merchant.where("name ILIKE '%#{search_params}%'").limit(1).first
  end

  def self.sort_by_revenue(quantity)
    binding.pry
  end
end
