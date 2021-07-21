class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.find_by_name(search_params)
    Merchant.where("name ILIKE '%#{search_params}%'").limit(1).first
  end

  def self.get_revenue_from(id)
    merchant_and_revenue = Merchant.joins(:transactions)
      .select("merchants.id, merchants.name, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
      .where("merchants.id = ? AND invoices.status='shipped' AND transactions.result='success'", id)
      .group('merchants.id').first

    # If merchant doesn't have revenue, still provide an output
    # This could turn into a helper method
    if merchant_and_revenue.nil?
      Merchant.select("merchants.id, merchants.name, 0.00 as revenue").where("merchants.id = ?", id).first
    else
      merchant_and_revenue
    end
  end

  def self.sort_by_revenue(quantity = 5)
    Merchant.joins(:transactions)
      .select("merchants.id, merchants.name, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
      .where("invoices.status='shipped' AND transactions.result='success'")
      .group('merchants.id')
      .order('revenue DESC')
      .limit(quantity)
  end
end
