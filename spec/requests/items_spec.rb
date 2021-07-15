require 'rails_helper'

RSpec.describe 'Items API Endpoints' do
  let!(:merchant_1) { merchant_with_items(30) }
  let!(:merchant_2) { merchant_with_items(40) }
  let!(:merchant_3) { merchant_with_items(30) }
  let(:item) {merchant_1.items.first}

  describe 'GET /items' do
    before { get '/api/v1/items' }

    it 'returns a paginated list of items' do
      expect(json[:data].length).to eq 20
    end

    it 'returns status code 200' do
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /items/:id' do
    context 'happy path' do
      before { get "/api/v1/items/#{item.id}" }

      it 'returns item attributes with status 200' do
        expect(response).to have_http_status 200
        expect(json[:data][:attributes][:name]).to eq item.name
        expect(json[:data][:attributes][:unit_price]).to eq item.unit_price
        expect(json[:data][:attributes][:merchant_id]).to eq merchant_1.id
      end
    end

    context 'sad path' do
      before { get "/api/v1/items/2092309" }

      it 'returns a message with error codes' do
        expect(response).to have_http_status 404
        expect(json[:message]).to eq "Query unable to be resolved."
      end
    end

  end

  describe 'POST /items' do
    let(:valid_attributes) { { name: "Maxwell Silver Hammer",
                             description: "It falls down on people's heads.",
                             unit_price: 888.88,
                             merchant_id: merchant_1.id } }


    # No name present
    # Need to add validation to model for that though...
    let(:invalid_attributes) { { description: "It falls down on people's heads.",
                             unit_price: 888.88,
                             merchant_id: merchant_1.id } }

    context 'happy path' do
      before { post '/api/v1/items', params: valid_attributes }

      it 'creates an item' do
        expect(json[:data][:type]).to eq "item"
        expect(json[:data][:attributes][:name]).to eq "Maxwell Silver Hammer"
        expect(response).to have_http_status 201
      end
    end

    context 'sad path' do
      before { post '/api/v1/items', params: invalid_attributes }

      it 'returns error information' do
        expect(response).to have_http_status 422
        # Need to check whether response actually sends this back
        expect(json[:message]).to match /Record unable to be processed./
      end

    end
  end


end

