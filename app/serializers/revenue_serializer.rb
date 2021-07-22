class RevenueSerializer
  include JSONAPI::Serializer
  set_id { nil }
  attributes :revenue
end
