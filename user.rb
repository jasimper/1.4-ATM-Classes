class User
  attr_accessor :name, :pin, :balance

  def initialize(name, pin, balance)
    @name     = name
    @pin      = pin
    @balance  = balance
  end

  def name
    @name
  end

  def balance
    @balance.to_i
  end

  def check_balance
    "#{name}, your current balance is #{balance}."
  end

  def withdraw
    @balance - withdraw_amount
  end
end
