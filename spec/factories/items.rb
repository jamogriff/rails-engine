FactoryBot.define do
  factory :item do
    name { Faker::TvShows::SiliconValley.invention }
    description {Faker::TvShows::SiliconValley.motto }
    unit_price { Faker::Number.within(range: 12.0..132123.0) }
    merchant
  end
end
