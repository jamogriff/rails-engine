require 'rails_helper'

RSpec.describe Merchant do

  describe 'relationships/validations' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'search methods' do
    let!(:merchants) { create_list(:merchant, 20) }

    it 'returns one result based on case-insensitive name' do
      create(:merchant, name: "Silvio Armandi")
      search_1 = "sil"
      search_2 = "arm"
    
      expect(Merchant.find_by_name(search_1).name).to eq "Silvio Armandi"
      expect(Merchant.find_by_name(search_2).name).to eq "Silvio Armandi"
    end
  end

  describe 'revenue methods' do
    # Creates merchants with item, invoices, transactions and invoice items
    let!(:merchants) do
      10.times do
        merchant_with_everything
      end
    end

    it 'returns list of x merchants sorted by revenue' do
      sorted_merchants = Merchant.sort_by_revenue(3)
      top_merchant = sorted_merchants.first
      second_merchant = sorted_merchants.second
      bottom_merchant = sorted_merchants.last

      expect(sorted_merchants.length).to eq 3
      expect(top_merchant.revenue).to be >= second_merchant.revenue
      expect(second_merchant.revenue).to be > bottom_merchant.revenue
    end
    
    it 'returns one merchant and their revenue' do
      merchant = Merchant.all.first
      revenue = Merchant.get_revenue_from(merchant.id)

      expect(revenue.name).to eq merchant.name
      expect(revenue.revenue).to be_a Float
    end
  end
end
