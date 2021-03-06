require 'rails_helper'

# NOTE: json is custom helper defined in support dir
RSpec.describe 'Merchants API' do
  # initialze Factorybot
  let!(:merchants) {create_list(:merchant, 50)}
  let!(:merchant) { merchant_with_items }
  let(:merchant_id) { merchant.id}
  let(:merchant_items) { merchant.items }

  describe 'GET /api/v1/merchants' do
    # make http request
    before { get '/api/v1/merchants' }

    it 'returns list of merchants' do
      expect(json).not_to be_empty
      expect(json[:data].length).to eq 20
    end

    it 'returns status code 200' do
      expect(response).to have_http_status 200
    end
  end

  describe 'pagination for GET /api/v1/merchants' do

    it 'returns list of 30 merchants' do
      get '/api/v1/merchants?page=1&per_page=30'
      expect(json[:data].length).to eq 30
    end

    it 'returns page 1 if param is 0 or negative' do
      get '/api/v1/merchants?page=0&per_page=50'
      expect(json[:data]).not_to be_empty
    end

    it 'defaults to 20 per page if param is 0 or negative' do
      get '/api/v1/merchants?page=1&per_page=-1'
      expect(json[:data].length).to eq 20
    end

    it 'conforms to both parameters' do
      get '/api/v1/merchants?page=2&per_page=40'
      expect(json[:data].length).to eq 11
    end

  end

  describe 'GET /api/v1/merchants/:id' do
    before { get "/api/v1/merchants/#{merchant_id}" }

    context 'happy path' do
      it 'returns correct data' do
        expect(json[:data][:attributes][:name]).to eq merchant.name
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'sad path' do
      it 'returns 404 error if id not found' do
        get '/api/v1/merchants/232322'
        expect(json[:message]).to eq "Query unable to be resolved."
        expect(response).to have_http_status 404
      end
    end
  end

  describe 'GET /api/v1/merchants/:id/items' do
    before { get "/api/v1/merchants/#{merchant_id}/items" }

    context 'happy path' do
      it 'returns one merchants items' do
        item_1 = merchant_items.first
        item_2 = merchant_items.last
        expect(json[:data].length).to eq merchant_items.length
        expect(json[:data][0][:attributes][:name]).to eq item_1.name
        expect(json[:data][-1][:attributes][:name]).to eq item_2.name
      end
    end
  end

end
      
