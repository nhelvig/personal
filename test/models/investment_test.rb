require 'test_helper'

class InvestmentTest < ActiveSupport::TestCase

  def setup
    @firstTransaction = Transaction.new({"symbol" => "GE", "quantity" => 5, "price" => 10.0, "action" => "buy"})
    @buyTransaction = Transaction.new({"symbol" => "GE", "quantity" => 5, "price" => 20.0, "action" => "buy"})
    @sellTransaction = Transaction.new({"symbol" => "GE", "quantity" => 1, "price" => 20.0, "action" => "sell"})
    @investment = Investment.build(@firstTransaction)
  end
  def teardown
    Investment.destroy("GE")
    Investment.setTotalInvested(0)
  end

  test "A new investment should have a symbol, quantity, total value, current price, and average cost" do
    assert_not_nil(@investment.symbol, "No symbol when the investment was created")
    assert_not_nil(@investment.quantity, "No quantity when the investment was created")
    assert_not_nil(@investment.total_value, "No total value when the investment was created")
    assert_not_nil(@investment.current_price, "No current price when the investment was created")
    assert_not_nil(@investment.avg_cost, "No average cost when the investment was created")
  end

  test "A new investment should have the same information as the transaction it was started with" do
    assert_equal(@investment.symbol, @firstTransaction.symbol, "Symbols do not match")
    assert_equal(@investment.quantity, @firstTransaction.quantity, "Quantity does not match")
    assert_equal(@investment.total_value, @firstTransaction.price * @firstTransaction.quantity, "Value does not match price * quantity")
    assert_equal(@investment.current_price, @firstTransaction.price, "Current price does not match the transaction price")
    assert_equal(@investment.avg_cost, @firstTransaction.price, "Average cost does not match the transaction price")
  end

  test "A single buy transaction should update the average cost" do
    @investment.addTransaction(@buyTransaction)

    assert_equal("15.0", @investment.avg_cost.to_s)
  end

  test "A single buy transaction should update the quantity" do
    @investment.addTransaction(@buyTransaction)

    assert_equal("10.0", @investment.quantity.to_s)
  end

  test "A single buy transaction should update the total value" do
    @investment.addTransaction(@buyTransaction)

    assert_equal("150.0", @investment.total_value.to_s)
  end

  test "A single buy transaction should update the total invested" do
    @investment.addTransaction(@buyTransaction)

    assert_equal("150.0", Investment.getTotalInvested.to_s)
    end

  test "A single sell transaction should update the quantity" do
    @investment.addTransaction(@sellTransaction)

    assert_equal("4.0", @investment.quantity.to_s)
  end

  test "A single sell transaction should update the total value" do
    @investment.addTransaction(@sellTransaction)

    assert_equal("30.0", @investment.total_value.to_s)
  end

  test "A single sell transaction should not change the total invested" do
    @investment.addTransaction(@sellTransaction)

    assert_equal("50.0", Investment.getTotalInvested.to_s)
  end

end
