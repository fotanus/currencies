require 'spec_helper'
require 'currency_history_fetcher'

describe CurrencyHistoryFetcher do
  it_should_behave_like "fetcher interface" do
    let(:url_regexp) { /https:\/\/min-api\.cryptocompare\.com\/data\/histoday.*/ }
    let(:api_response_file_path) { "spec/fixtures/exchange_rate_dummy_response.txt" }
    let(:fetch_params) { %w(ETH) }
  end
end
