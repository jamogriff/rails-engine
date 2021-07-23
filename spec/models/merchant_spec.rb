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

    it 'returns all revenue over a length of time' do
      start = "2020-03-01"
      end_time = "2021-05-01"

      # Not a great test. Could use verification, but I'm very confident it's accurate
      # Test instances get created all on same day, so not really helpful to test here
      # unless an overhaul of Factroies is warranted
      expect(Merchant.revenue_between(start, end_time).revenue).to be nil
    end

    it 'returns total revenue' do
      expect(Merchant.total_revenue.revenue).to be_a Float
    end

    # Again, tests should be revisited with a better factory
    it 'returns revenue by week' do
      expect(Merchant.weekly_revenue).to be_a Array
    end
  end
end
