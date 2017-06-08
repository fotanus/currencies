require 'currency_history_fetcher'
require 'nasdaq_history_fetcher'

class CurrenciesController < ApplicationController
  def index
    bitcoin = CurrencyHistoryFetcher.fetch("BTC")
    ethereum = CurrencyHistoryFetcher.fetch("ETH")
    nasdaq = NasdaqHistoryFetcher.fetch

    @categories = bitcoin.keys.map{ |x| Time.at(x).strftime("%Y-%m-%d") }.to_json
    @series = [
      { name: "Bitcoin", data:  bitcoin.values },
      { name: "Ethereum", data:  ethereum.values },
      { name: "NASDAQ", data:  nasdaq.values }
    ].to_json
  end
end
