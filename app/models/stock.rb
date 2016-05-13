require 'stock_quote'

class Stock < ActiveRecord::Base
  validates :symbol, presence: true

  def get_current_stock_info(symbol)
    StockQuote::Stock.quote(symbol)
  end

  def get_stock_price
    return get_current_stock_info(symbol).last_trade_price_only
  end



end
