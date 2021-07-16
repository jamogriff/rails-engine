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
  end
end
