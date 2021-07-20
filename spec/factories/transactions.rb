FactoryBot.define do
  statuses = ["success", "failed"]

  factory :transaction do
    result { statuses[rand(2)] }
    invoice
  end
end
