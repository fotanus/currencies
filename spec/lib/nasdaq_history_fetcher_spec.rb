require 'spec_helper'

describe NasdaqHistoryFetcher do
  it_should_behave_like "fetcher interface" do
    let(:url_regexp) { /http:\/\/www.alphavantage.co\/query.*/ }
    let(:api_response_file_path) { "spec/fixtures/nasdaq_rate_dummy_response.txt" }
    let(:fetch_params) { [] }
  end
end
