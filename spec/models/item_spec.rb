require 'rails_helper'

RSpec.describe Item do
  describe 'relationships/validations' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items).dependent(:destroy) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
  end

  describe 'class methods' do
    let!(:merchant_1) { merchant_with_items(20) }
    let!(:merchant_2) { merchant_with_items(20) }

    it 'returns results based on case-insensitive name' do
      create(:item, name: "Tres Comas Tequila")
      create(:item, name: "Anton")

      search_1 = "tres"
      search_2 = "an"
    
      expect(Item.find_all(search_1).pluck(:name)).to include "Tres Comas Tequila"
      expect(Item.find_all(search_2).pluck(:name)).to include "Anton"
    end
  end

end
