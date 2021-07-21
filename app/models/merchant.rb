class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.find_by_name(search_params)
    Merchant.where("name ILIKE '%#{search_params}%'").limit(1).first
  end

  def self.sort_by_revenue(quantity)
    Merchant.joins(:transactions).select("merchants.id, merchants.name, sum(invoice_items.unit_price * invoice_items.quantity) as revenue").where("invoices.status='shipped' AND transactions.result='success'").group('merchants.id').order('revenue DESC').limit(quantity)
  end
end
