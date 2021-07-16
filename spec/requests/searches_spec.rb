require 'rails_helper'

# NOTE There are two separate search controllers, each
# dedicated for merchants and items respectively.

# The idea is if they're split up then one allows
# more discrete control over search parameters than
# lumping everything into one controller.
RSpec.describe 'Search functionality' do
  let!(:merchants) {create_list(:merchant, 20)}
  let!(:merchant) { merchant_with_items(30) }

  describe 'for merchants' do
    it 'can find selected merchant' do
      create(:merchant, name: "Spaceship Inc")
      get '/api/v1/merchants/find', params: { name: "space" }

      expect(response).to have_http_status 200
      expect(json[:data][:attributes][:name]).to eq "Spaceship Inc"
    end

  end

  describe 'for items' do
    it 'can find all relevant items' do
      create(:item, name: "Tres Comas Tequila")
      create(:item, name: "Tacos Otres")
      get '/api/v1/items/find_all', params: { name: "tres" }

      expect(response).to have_http_status 200
      expect(json[:data].length).to be >= 2
    end

  end

end
