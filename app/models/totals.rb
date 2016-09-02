class Totals < ActiveRecord::Base

def percentageChange
  (((total_value/total_invested) - 1) * 100).round(2)
end

  def getTotalValue
    total_value.round(2)
  end
  def getTotalInvested
    total_invested.round(2)
  end

  def getAvailableCash
    available_cash.round(2)
  end

  def getTotalDividend
    total_dividend.round(2)
    end

  def getPercentageChange
    percentage_change.round(2)
  end

end