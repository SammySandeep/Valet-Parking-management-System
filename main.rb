require_relative 'app'
require_relative 'parking'

def main
  puts 'Welcome to Valet Parking Management'
  puts "\n"
  puts " Please Enter the Parking Spots Available \n"
  puts "\n"
  puts ' Enter Number of Small Parking Spots: '
  small = gets.chomp.to_i
  puts ' Enter Number of Medium Parking Spots: '
  medium = gets.chomp.to_i
  puts ' Enter Number of Large Parking Spots: '
  large = gets.chomp.to_i

  parking_garage = ParkingGarage.new(small, medium, large)
  loop do
    app = App.new(parking_garage)
    app.run
  end
end

main