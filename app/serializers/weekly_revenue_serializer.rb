class WeeklyRevenueSerializer
  include JSONAPI::Serializer
  extend ActionView::Helpers::NumberHelper # for converting to currency format

  # Removes timestamp from week
  attribute :week do |object|
    object.week.to_s[0..9]
  end

  attribute :revenue
end
