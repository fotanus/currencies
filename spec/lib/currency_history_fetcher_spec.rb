require 'spec_helper'
require 'currency_history_fetcher'

describe CurrencyHistoryFetcher do
  describe ".fetch" do
		context "when successfully retrieves the data from external api" do
			before do
				stub_request(
          :get, /https:\/\/min-api\.cryptocompare\.com\/data\/histoday.*/
				).to_return(
					body: File.read("spec/fixtures/exchange_rate_dummy_response.txt")
				)
			end
			it "returns a hash" do
				expect(subject.class.fetch("ETH")).to be_kind_of(Hash)
			end
			it "keys are dates" do
				expect(subject.class.fetch("ETH").keys.first).to be_kind_of(Numeric)
			end
			it "values are price in USD" do
				expect(subject.class.fetch("ETH").values.first).to be_kind_of(Numeric)
			end
		end

		context "when fails to retrieve data from external API" do
			before do
				stub_request(
          :get, /https:\/\/min-api\.cryptocompare\.com\/data\/histoday.*/
				).to_return(
					status: [500, "Internal Server Error"]
				)
			end
			it "returns an empty hash" do
				expect(subject.class.fetch("ETH")).to eq({})
			end
		end
	end
end
