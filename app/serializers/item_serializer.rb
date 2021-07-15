class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price, :merchant_id

  # You could add this instead of merchant_id attribute
  #belongs_to :merchant
end
