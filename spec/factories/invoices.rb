FactoryBot.define do
  statuses = ["shipped", "pending"]

  factory :invoice do
    status { statuses[rand(2)] }
    merchant
  end
end
