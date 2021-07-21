require 'rails_helper'

RSpec.describe 'Revenue endpoints' do
  before :all do
    15.times do
      merchant_with_everything
    end
  end

  describe '/api/v1/revenue/merchants' do
    describe 'happy path' do
      it 'returns top 5 merchants sorted by revenue' do
        get '/api/v1/revenue/merchants'

        expect(response).to have_http_status 200
        expect(json[:data].length).to eq 5
        expect(json[:data][0][:attributes][:revenue]).to be_instance_of Float
      end

      it 'returns top x of users choice' do
        get '/api/v1/revenue/merchants?quantity=2'

        expect(response).to have_http_status 200
        expect(json[:data].length).to eq 2
      end
    end

    describe 'sad path' do
      it 'can handle when quantity is not a number' do
        get '/api/v1/revenue/merchants?quantity=marshmellow'
        expect(response).to have_http_status 400
      end

    end
  end

end
