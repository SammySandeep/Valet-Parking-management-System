class ParkingGarage
    attr_reader :parking_spots, :small, :medium, :large
  
    def initialize(small, medium, large)
      @small = small
      @medium = medium
      @large = large
      @parking_spots = {
        small_spot: [],
        medium_spot: [],
        large_spot: []
      }
    end
  
    def admitTheCar(license_plate_no, car_size)
      car = { car: license_plate_no, size: car_size }
      case car_size
      when 'small'
        if @small > 0
          @parking_spots[:small_spot] << car
          @small -= 1
          parking_status(car, 'small')
        elsif @medium > 0
          @parking_spots[:medium_spot] << car
          @medium -= 1
          parking_status(car, 'medium')
        elsif @large > 0
          @parking_spots[:large_spot] << car
          @large -= 1
          parking_status(car, 'large')
        else
          parking_status
        end
  
      when 'medium'
        if @medium > 0
          @parking_spots[:medium_spot] << car
          @medium -= 1
          parking_status(car, 'medium')
        elsif @large > 0
          @parking_spots[:large_spot] << car
          @large -= 1
          parking_status(car, 'large')
        elsif @medium.zero? && @large.zero?
          shuffle_medium(car)
        else
          parking_status
        end
  
      when 'large'
        if @large > 0
          parking_spots[:large_spot] << car
          @large -= 1
          parking_status(car, 'large')
        elsif @large.zero?
          shuffle_large(car)
        else
          parking_status
        end
      end
    end
  
    def exitTheCar(license_plate_no)
      small_car = @parking_spots[:small_spot].find { |car| car[:car] == license_plate_no }
      medium_car = @parking_spots[:medium_spot].find { |car| car[:car] == license_plate_no }
      large_car = @parking_spots[:large_spot].find { |car| car[:car] == license_plate_no }
  
      if small_car
        @parking_spots[:small_spot].delete(small_car)
        @small += 1
        exit_status(license_plate_no)
      elsif medium_car
        @parking_spots[:medium_spot].delete(medium_car)
        @medium += 1
        exit_status(license_plate_no)
      elsif large_car
        @parking_spots[:large_spot].delete(large_car)
        @large += 1
        exit_status(license_plate_no)
      else
        exit_status
      end
    end
  
    def shuffle_medium(car)
      if !@small.zero? && (@parking_spots[:medium_spot].any? do |car|
                             car[:size] == 'small'
                           end || @parking_spots[:large_spot].any? do |car|
                                    car[:size] == 'small'
                                  end)
        small_at_medium = @parking_spots[:medium_spot].find { |car| car[:size] == 'small' }
        small_at_large = @parking_spots[:large_spot].find { |car| car[:size] == 'small' }
        if small_at_medium
          @parking_spots[:medium].delete(small_at_medium)
          @parking_spots[:medium] << car
          parking_status(car, 'medium')
          @parking_spots[:small] << small_at_medium
          @small -= 1
          parking_status(small_at_medium, 'small')
        elsif small_at_large
          @parking_spots[:large].delete(small_at_large)
          @parking_spots[:large] << car
          parking_status(car, 'large')
          @parking_spots[:small] << small_at_large
          @small -= 1
          parking_status(small_at_large, 'small')
        end
      end
    end
  
    def shuffle_large(car)
      if !@medium.zero? && @parking_spots[:large_spot].any? { |car| car[:size] == 'medium' }
        medium_at_large = @parking_spots[:large_spot].find { |car| car[:size] == 'medium' }
        @parking_spots[:large_spot].delete(medium_at_large)
        @parking_spots[:large_spot] << car
        parking_status(car, 'large')
        @parking_spots[:medium_spot] << medium_at_large
        @medium -= 1
        parking_status(medium_at_large, 'medium')
      end
      if (!@small.zero? || !@medium.zero?) && @parking_spots[:large_spot].any? { |car| car[:size] == 'small' }
        small_at_large = @parking_spots[:large_spot].find { |car| car[:size] == 'small' }
        @parking_spots[:large_spot].delete(small_at_large)
        @parking_spots[:large_spot] << car
        parking_status(car, 'large')
        if !@small.zero?
          @parking_spots[:small_spot] << small_at_large
          @small -= 1
          parking_status(small_at_large, 'small')
        elsif !@medium.zero?
          @parking_spots[:medium_spot] << small_at_large
          @medium -= 1
          parking_status(small_at_large, 'medium')
        end
      end
    end
  
    def parking_status(car = nil, space = nil)
      if car && space
        puts "Car with license plate no: #{car[:car]} is parked at #{space} "
      else
        puts 'No space available'
      end
    end
  
    def exit_status(license_plate = nil)
      if license_plate
        puts "Car with license plate no: #{license_plate} exited"
      else
        puts 'Car not found!'
      end
    end
  end
