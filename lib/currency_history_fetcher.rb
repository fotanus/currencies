require 'rest-client'

class CurrencyHistoryFetcher
  def self.fetch(currency)
    url = "https://min-api.cryptocompare.com/data/histoday"
    params = "?fsym=#{currency}&tsym=USD&toTs=#{Time.now.to_i}"
    Rails.cache.fetch("CurrencyFetcher-"+currency, expires_in: 2.hours) do
      begin
        resp_body = RestClient.get(url+params).body
        resp = JSON.parse(resp_body)
        if resp["Response"] == "Success"
          Hash[
            resp["Data"].map{ |d| [d["time"], d["close"]] }
          ]
        else
          {}
        end
      rescue RestClient::ExceptionWithResponse => err
        {}
      end
    end
  end
end
