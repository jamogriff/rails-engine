require 'rails_helper'

# NOTE: json is custom helper defined in support dir
RSpec.describe 'Merchants API' do
  # initialze Factorybot
  let!(:merchants) {create_list(:merchant, 10)}
  let(:merchant_id) {:merchants.first.id}

  describe 'GET /api/v1/merchants' do
    # make http request
    before { get '/api/v1/merchants' }

    it 'returns list of merchants' do
      expect(json).not_to be_empty
      expect(json.length).to eq 10
    end

    it 'returns status code 200' do
      expect(response).to have_http_response 200
    end
  end

end
      
