require "csv"
require "./user.rb"

### CSV set-up
current_users = []
csv = CSV.foreach('./users.csv', headers: true, header_converters: :symbol) { |row|
  row.to_hash
  user = User.new(row[:name], row[:pin], row[:balance])
# Curious if there is a way to do this without creating an array.
# All the User info is right here, I just don't know how to access it...
# ... unless I push it to an array.
  current_users.push(user)
}
puts current_users.inspect
def user_input(text)
  var = ""
  while var == ""
    puts text
    print "> "
    var = gets.chomp
  end
  var
end

def error_msg(text)
  puts text
end
# Method to start back at the sign in menu, but I can't figure it out yet.
# def start_over
#   yes_no = nil
#   puts "Would you like to start over? Please enter either y/n."
#   yes_no = gets.slice(0)
#   if yes_no == "y" || "Y"
#
#   elsif yes_no == "n" || "N"
#     puts "Thank you. Have a good day!"
#   end
# end

### Login

current_name = user_input("Please enter your first name:")
current_pin = user_input("Please enter your PIN:")

verified_user = nil
current_users.each do |user|
  if user.name == current_name && user.pin == current_pin
  verified_user = user
  end
end

### ATM Options Menu

if verified_user
  puts "Welcome #{verified_user.name}."

  option_menu = ["1. Check Balance", "2. Withdraw funds", "3. Cancel"]
  choice = nil
   until (1..option_menu.length).include?(choice)
    choice = puts "Please enter an option by its cooresponding number:\n#{option_menu.join(" | ")}"
    print "> "
    choice = gets.to_i
  end

### ATM Actions

atm_balance = 50000
  if choice == 1
    puts verified_user.check_balance
  elsif choice == 2
    puts "How much would you like to withdraw?"
    print "> "
    withdraw_amount = gets.chomp.to_i
      if atm_balance < withdraw_amount
        error_msg("Sorry. ATM Out of Order.")
      elsif withdraw_amount > verified_user.balance
        error_msg("Bummer. You do not have enough funds.")
      else verified_user.balance -= withdraw_amount
        puts %{
        **********************

        Amount withdrawn: $#{withdraw_amount}.
        Current balance:  $#{verified_user.balance}.

        Thank you.

        **********************
        }
      end
  else choice == 3
    puts "Thanks. Please come again!"
  end
else
  error_msg("Your information cannot be verified.")
  # start_over
end
