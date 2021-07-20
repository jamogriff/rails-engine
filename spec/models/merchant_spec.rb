require 'rails_helper'

RSpec.describe Merchant do

  describe 'relationships/validations' do
    it { should have_many(:items) }
  end

  describe 'class methods' do
    let!(:merchants) { create_list(:merchant, 20) }

    it 'returns one result based on case-insensitive name' do
      create(:merchant, name: "Silvio Armandi")
      search_1 = "sil"
      search_2 = "arm"
    
      expect(Merchant.find_by_name(search_1).name).to eq "Silvio Armandi"
      expect(Merchant.find_by_name(search_2).name).to eq "Silvio Armandi"
    end

    it 'returns list of x merchants sorted by revenue' do
      top_merchant = Merchant.sort_by_revenue(10).first
      second_merchant = Merchant.sort_by_revenue(10).second
      bottom_merchant = Merchant.sort_by_revenue(10).last

      expect(Merchant.sort_by_revenue(10).length).to eq 10
      expect(top_merchant.revenue).to be >= second_merchant.revenue
      expect(second_merchant.revenue).to be > bottom_merchant.revenue
    end
  end
end
