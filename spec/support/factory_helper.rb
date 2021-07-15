module FactoryHelper

  def merchant_with_items(quantity = 5)
    FactoryBot.create(:merchant) do |merch|
      FactoryBot.create_list(:item, quantity, merchant: merch)
    end
  end

end


