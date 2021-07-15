class InvoiceItem < ApplicationRecord
  belongs_to :item, dependent: :destroy

end
