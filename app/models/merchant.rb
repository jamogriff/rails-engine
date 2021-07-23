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
      Merchant.select("merchants.id, merchants.name, sum(0 + 0.00) as revenue").where("merchants.id = ?", id).first
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

  # Originally just returned a float, but needed a pseudo-object for serialization
  def self.revenue_between(start_time, end_time)
    result = Merchant.joins(:transactions).select("sum(invoice_items.quantity * invoice_items.unit_price) as revenue").where("invoices.status = 'shipped' AND transactions.result = 'success' AND invoices.created_at >= date '#{start_time}' AND invoices.created_at <= date '#{end_time}'")
    result[0] # used to remove array
  end

  # Originally just returned a float, but needed a pseudo-object for serialization
  def self.total_revenue
    result = Merchant.joins(:transactions).select("sum(invoice_items.quantity * invoice_items.unit_price) as revenue").where("invoices.status = 'shipped' AND transactions.result = 'success'")
    result[0]
  end

  def self.weekly_revenue
    Merchant.joins(:transactions).select("date_trunc('week', invoices.created_at) as week, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").where("invoices.status = 'shipped' AND transactions.result = 'success'").group("week").order("week")
  end
end
