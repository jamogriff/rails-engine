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

  describe '/api/v1/revenue/merchants/:id' do
    describe 'happy path' do
      it 'returns a merchant with their revenue' do
        merchant = Merchant.all.first
        get "/api/v1/revenue/merchants/#{merchant.id}"

        expect(response).to have_http_status 200
        expect(json[:data][:attributes][:name]).to eq merchant.name
        expect(json[:data][:attributes][:revenue]).to be_a Float
      end
    end

    describe 'sad path' do
      it 'returns error if id is doesn\'t match db' do
        get "/api/v1/revenue/merchants/90909"
        
        expect(response).to have_http_status 404
      end

      it 'returns error if id is invalid' do
        get "/api/v1/revenue/merchants/lolstrings"
        
        expect(response).to have_http_status 400
      end
    end
  end

  describe '/api/v1/revenue/' do
    describe 'happy path' do
      it 'returns revenue for everything by default' do
        get '/api/v1/revenue'

        expect(response).to have_http_status 200
        expect(json[:data][:attributes][:revenue]).to be_a Float
      end

      it 'returns revenue between two dates' do
        get '/api/v1/revenue?start_date=2012-03-05&end_date=2012-03-27'

        expect(response).to have_http_status 200
        expect(json[:data][:attributes][:revenue]).to be_a Float
      end
    end

    describe 'sad path' do
      it 'returns 400 if one params is missing' do
        get '/api/v1/revenue?end_date=2021-03-27'

        expect(response).to have_http_status 400
      end

      it 'returns 400 if params are garbage' do
        get '/api/v1/revenue?end_date=stringcheese'

        expect(response).to have_http_status 400
      end

      it 'returns 400 if params are in wrong format' do
        get '/api/v1/revenue?start_date=09-21-2012&end_date=10-23-2012'

        expect(response).to have_http_status 400
      end
    end
  end

  describe '/api/v1/revenue/weekly' do
    describe 'happy path' do
      it 'returns revenue broken down by week' do
        get '/api/v1/revenue/weekly'

        expect(response).to have_http_status 200
        expect(json[:data][0][:attributes][:week]).to be_a String
        expect(json[:data][0][:attributes][:revenue]).to be_a String
      end
    end
  end

end
