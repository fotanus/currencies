require 'currency_history_fetcher'
require 'nasdaq_history_fetcher'

class CurrenciesController < ApplicationController
  def index
    bitcoin = CurrencyHistoryFetcher.fetch("BTC")
    ethereum = CurrencyHistoryFetcher.fetch("ETH")
    nasdaq = NasdaqHistoryFetcher.fetch

    @categories = bitcoin.keys.map{ |x| Time.at(x).strftime("%Y-%m-%d") }.to_json

    usd_series_base = {
      yAxis: 0,
      tooltip: { valuePrefix: 'US$ ' }
    }
    points_series_base = {
      yAxis: 1,
      dashStyle: 'longdash',
      tooltip: { valueSuffix: ' points' }
    }
    @series = [
      usd_series_base.merge({ name: "Bitcoin", data:  bitcoin.values }),
      usd_series_base.merge({ name: "Ethereum", data:  ethereum.values }),
      points_series_base.merge({ name: "NASDAQ", data:  nasdaq.values })
    ].to_json
  end
end
