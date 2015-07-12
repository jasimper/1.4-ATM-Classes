class User
  attr_accessor :name, :pin, :balance

  def initialize(name, pin, balance)
    self.name    = name
    self.pin     = pin
    self.balance = balance.to_i
  end

  def check_balance
    "#{name}, your current balance is #{balance}."
  end

end
