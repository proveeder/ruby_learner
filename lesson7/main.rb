require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'station'

class Main
  COMMANDS = {
    1 => :create_station,
    2 => :create_train,
    3 => :create_wagon,
    4 => :add_wagon_to_train,
    5 => :remove_wagon_from_train,
    6 => :move_train_to_station,
    7 => :list_all_stations,
    8 => :list_of_trains_on_station,
    9 => :show_trains_formatted,
    10 => :show_wagons_formatted,
    11 => :change_wagon_properties
  }.freeze

  def start
    puts puts 'Commands:
    1 create station
    2 create train
    3 create wagon
    4 add wagon to train
    5 remove wagon from train
    6 move train to station
    7 list all stations
    8 list of trains on station
    9 show trains formatted
    10 show wagons formatted
    11 change wagon properties'

    loop do
      # puts @objects
      puts 'Enter command'
      command = gets.chomp.to_i
      send COMMANDS[command]
    end
  end

  private

  def change_wagon_properties
    puts 'Enter wagon name'
    wagon_name = gets.chomp

    wagon = get_obj_(Wagon, wagon_name)
    if wagon.instance_of?(CargoWagon)
      puts 'Enter volume'
      volume = gets.chomp.to_i
      wagon.nil? ? puts('Error') : wagon.change_volume(volume)
    elsif wagon.instance_of?(PassengerWagon)
      wagon.nil? ? puts('Error') : wagon.take_one_place
    end
  end

  def get_obj(cls, name)
    object = ObjectSpace.each_object(cls).to_a.filter { |o| o.instance_of?(cls) }
    object.find { |o| o.name == name }
  end

  def get_obj_(cls, name)
    classes = cls.subclasses << cls
    obj = nil
    classes.each do |c|
      q = ObjectSpace.each_object(c).to_a.filter { |o| o.name == name }
      q = q.find { |o| o.name == name }
      obj = q unless q.nil?
      break unless obj.nil?
    end
    obj
  end

  def list_of_trains_on_station
    puts 'Enter station name'
    station_name = gets.chomp

    station = get_obj(Station, station_name)
    station.nil? ? puts('Error') : puts(station.trains_on_station)
  end

  def list_all_stations
    ObjectSpace.each_object(Station).to_a.each { |station| puts(station.name) }
  end

  def move_train_to_station
    puts 'Enter train name'
    train_name = gets.chomp

    puts 'Enter station name'
    station_name = gets.chomp

    train = get_obj_(Train, train_name)

    station = get_obj(Station, station_name)

    train.nil? ? puts('Unable to do that') : train.specify_current_station(station)
  end

  def remove_wagon_from_train
    puts 'Enter wagon name'
    wagon_name = gets.chomp

    puts 'Enter train name'
    train_name = gets.chomp

    train = get_obj_(Train, train_name)
    wagon = get_obj_(Train, wagon_name)

    train.nil? || wagon.nil? ? puts('Error') : train.remove_wagon(wagon)
  end

  def add_wagon_to_train
    puts 'Enter wagon name'
    wagon_name = gets.chomp

    puts 'Enter train name'
    train_name = gets.chomp

    train = get_obj_(Train, train_name)
    wagon = get_obj_(Wagon, wagon_name)

    train.nil? || wagon.nil? ? puts('Error') : train.add_wagon(wagon)
  end

  def create_wagon
    puts 'Enter wagon name'
    name = gets.chomp
    puts 'Enter wagon type or skip to set default'
    wagon_type = gets.chomp

    case wagon_type
    when 'cargo'
      puts 'Enter volume'
      volume = gets.chomp.to_f
      CargoWagon.new(name, volume)
      puts 'Success'
    when 'passenger'
      puts 'Enter amount of places'
      places = gets.chomp.to_i
      PassengerWagon.new(name, places)
      puts 'Success'
    when ''
      Wagon.new(name)
      puts 'Success'
    else
      puts 'Invalid input'
    end
  end

  def create_train
    attempts = 0
    begin
      puts 'Enter train name'
      train_name = gets.chomp

      puts 'Enter train number'
      train_number = gets.chomp

      puts 'Enter train type'
      type = gets.chomp

      case type
      when 'cargo'
        CargoTrain.new(train_name, train_number)
        puts 'Success'
      when 'passenger'
        PassengerTrain.new(train_name, train_number)
        puts 'Success'
      when ''
        Train.new(train_name, train_number)
        puts 'Success'
      else
        puts 'Invalid input'
      end
    rescue RuntimeError => e
      attempts += 1
      puts e.inspect
      attempts < 2 ? retry : puts("Failed after #{attempts} attempt(s)")
    end
  end

  def create_station
    puts 'Enter station name:'
    station_name = gets.chomp
    Station.new(station_name)
    puts 'Success'
  end

  def show_trains_formatted
    Station.do_for_each_train { |train| puts("#{train.name}, #{train.class}, #{train.wagons.length}") }
  end

  def show_wagons_formatted
    Station.do_for_each_train { |train|
      train.wagons.each do |wagon|
        puts("#{wagon.name}, #{wagon.class}")
        puts("#{wagon.taken_places}, #{wagon.places_available}") if wagon.instance_of?(PassengerWagon)
        puts("#{wagon.volume_available}, #{wagon.taken_volume}") if wagon.instance_of?(CargoWagon)
      end
    }
  end
end

Main.new.start
