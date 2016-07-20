require 'test_helper'

class InvestmentTest < ActiveSupport::TestCase
  transaction = Transaction.new({"symbol" => "GE", "quantity" => 2, "price" => 10.0, "action" => "buy"})

  test "A new investment should have a symbol, quantity, total value, current price, and average cost" do
    investment = Investment.build(transaction)
    assert_not_nil(investment.symbol, "No symbol when the investment was created")
    assert_not_nil(investment.quantity, "No quantity when the investment was created")
    assert_not_nil(investment.total_value, "No total value when the investment was created")
    assert_not_nil(investment.current_price, "No current price when the investment was created")
    assert_not_nil(investment.avg_cost, "No average cost when the investment was created")
  end

  test "An new investment should have the same information as the transaction it was started with" do
    investment = Investment.build(transaction)

    assert_equal(investment.symbol, transaction.symbol, "Symbols do not match")
    assert_equal(investment.quantity, transaction.quantity, "Quantity does not match")
    assert_equal(investment.total_value, transaction.price * transaction.quantity, "Value does not match price * quantity")
    assert_equal(investment.current_price, transaction.price, "Current price does not match the transaction price")
    assert_equal(investment.avg_cost, transaction.price, "Average cost does not match the transaction price")
  end
  
end
