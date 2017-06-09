require 'rest-client'

class NasdaqHistoryFetcher
  def self.fetch
    api_key = ENV["ALPHAVANTAGE_API_KEY"]
    url = "http://www.alphavantage.co/query"
    params = "?function=TIME_SERIES_DAILY&symbol=^IXIC&apikey=#{api_key}"
    Rails.cache.fetch("NASDAQHistoryFetcher", expires_in: 2.hours) do
      begin
        resp_body = RestClient.get(url+params).body
        resp = JSON.parse(resp_body)
        Hash[
          resp["Time Series (Daily)"]
            .map{ |k,v| [Time.parse(k).to_i, v["4. close"].to_f] }
            .sort{ |a,b| a[0] <=> b[0] }
            .last(31)
        ]
      rescue RestClient::ExceptionWithResponse => err
        {}
      end
    end
  end
end
