require "csv"
require "./user.rb"

current_users = []
csv = CSV.foreach('./users.csv', :headers => true, :header_converters => :symbol, :converters => :all) { |row|
  row.to_hash
  user = User.new(row[:name], row[:pin], row[:balance])
# Curious if there is a way to do this without creating an array.
# All the User info is right here, I just don't know how to access it...
# ... unless I push it to an array.
  current_users.push(user)
}
puts current_users.inspect

### Login

current_name = ""
  while current_name == ""
  puts "Please enter your first name"
    current_name = gets.chomp
  end
current_pin = ""
  while current_pin == ""
  puts "Please enter your PIN"
    current_pin = gets.chomp.to_i
  end
verified_user = nil
current_users.each do |user|
  if user.name == current_name && user.pin == current_pin
  verified_user = user
  end
end

### ATM Options Menu

if verified_user
  puts "Welcome."

  option_menu = ["1. Check Balance", "2. Withdraw funds", "3. Cancel"]
  choice = nil
   until (1..option_menu.length).include?(choice)
    choice = puts "Please enter an option by its cooresponding number:\n#{option_menu.join(" | ")}"
    choice = gets.to_i
  end

### ATM Actions

  atm_balance = 50000
    if choice == 3
      puts "Thanks. Please come again!"
    elsif choice == 1
      puts verified_user.check_balance
    elsif choice == 2
      puts "How much would you like to withdraw?"
      withdraw_amount = gets.chomp.to_i
        if atm_balance < withdraw_amount
          puts "Sorry. ATM Out of Order"
        elsif withdraw_amount > verified_user.balance
          puts "Bummer. You do not have enough funds."
        else verified_user.balance -= withdraw_amount
          puts %{
          Here is your #{withdraw_amount}.
          Your balance is now #{verified_user.balance}.
          Thank you.
          }
        end
    end
  else
    puts "Your information cannot be verified."
  end
