class User
  attr_accessor :name, :pin, :balance

  def initialize(name, pin, balance)
    @name     = name
    @pin      = pin
    @balance  = balance
  end



  def check_balance
    "Hello, #{name}. Your current balance is #{balance}."
  end

  def withdraw
    @balance - withdraw_amount
  end
end
