class Invoice < ApplicationRecord
  # Transactions is really a one to one relationship, but there is
  # an already defined #transaction method in AR that has use in Exceptions
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

end
