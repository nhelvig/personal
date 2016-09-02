class QuandlClient

  @@url = "https://www.quandl.com/api/v3/datasets/WIKI/%s.json?start_date=%s&end_date=%s&order=asc&column_index=4&collapse=daily&transformation=rdiff"

  def self.sendRequest(symbol, startDate)
    url = buildUrl(symbol, startDate, Date.today)
  end

  def self.buildUrl(symbol, startDate, endDate)
    url = @@url % [symbol, startDate.to_s, endDate.to_s]
    url
  end

end