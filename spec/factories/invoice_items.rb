FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.within(range: 1..13) }
    unit_price { Faker::Number.within(range: 12.0..132123.0) }
    item
    invoice
  end
end
