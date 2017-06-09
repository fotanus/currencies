require 'rails_helper'

RSpec.describe CurrenciesController, type: :controller do

  describe "GET #index" do
    before do
      stub_request(
        :get, /https:\/\/min-api\.cryptocompare\.com\/data\/histoday.*/,
      ).to_return(
        body: File.read("spec/fixtures/exchange_rate_dummy_response.txt")
      )
      stub_request(
        :get, /http:\/\/www.alphavantage.co\/query.*/
      ).to_return(
        body: File.read("spec/fixtures/nasdaq_rate_dummy_response.txt")
      )
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "uses the currency history fetcher" do
      expect(
        CurrencyHistoryFetcher
      ).to receive(:fetch).twice.and_call_original
      get :index
    end

    it "uses the nasdaq history fetcher" do
      expect(
        NasdaqHistoryFetcher
      ).to receive(:fetch).and_call_original
      get :index
    end
  end
end
