class App
    def initialize(parking_garage)
      @parking_garage = parking_garage
    end
  
    def run
      puts 'Please Choose an option by Entering a Number'
      puts ' 1 - Park a car'
      puts ' 2 - Exit a car'
      puts ' 0 - Exit app'
  
      option = gets.chomp.to_i
      case option
      when 1
        puts ' Enter Car license plate number: '
        license_plate_no = gets.chomp.to_s
        puts ' Enter Car size (Small, Medium or Large): '
        size = gets.chomp.to_s.downcase
        @parking_garage.admitTheCar(license_plate_no, size)
      when 2
        puts ' Enter Car license plate number: '
        license_plate = gets.chomp.to_s
        @parking_garage.exitTheCar(license_plate)
      when 0
        abort 'Thank you for using the app!'
      else
        puts "Invalid Entry #{option}"
      end
    end
  end