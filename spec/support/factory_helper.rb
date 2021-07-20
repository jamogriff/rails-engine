module FactoryHelper

  def merchant_with_items(quantity = 5)
    FactoryBot.create(:merchant) do |merch|
      FactoryBot.create_list(:item, quantity, merchant: merch)
    end
  end

  # Beefy helper method to create a default merchant with 2 invoices, 6 items, and between 0..6 invoice items
  def merchant_with_everything(quantity = 3)
    FactoryBot.create(:merchant) do |merch|
      invoices = create_invoices_and_transactions(merch) 
      invoices.each do |invoice|
        FactoryBot.create_list(:item, quantity, merchant: merch) do |item|
          boolean = rand(2)
          if boolean == 0
            FactoryBot.create(:invoice_item, invoice: invoice, item: item)
          end
        end
      end
    end
  end

  def create_invoices_and_transactions(merchant, quantity = 2)
    FactoryBot.create_list(:invoice, quantity, merchant_id: merchant.id) do |inv|
      FactoryBot.create(:transaction, invoice: inv)
    end
  end
end


