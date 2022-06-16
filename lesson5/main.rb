require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'station'

# docs
class Main
  def initialize
    @objects = []
  end

  def get_object_by_type(cls)
    @objects.select { |obj| obj.class <= cls }
  end

  def get_obj_by_type_and_name(cls, name)
    objects = get_object_by_type(cls)
    objects.select { |o| o.name == name }[0]
  end

  def list_of_trains_on_station
    puts 'Enter station name'
    station_name = gets.chomp

    station = get_obj_by_type_and_name(Station, station_name)
    puts station.trains_on_station
  end

  def list_all_stations
    stations = get_object_by_type(Station)
    stations.each { |station| puts(station.name) }
  end

  def move_train_to_station
    puts 'Enter train number'
    train_number = gets.chomp

    puts 'Enter station name'
    station_name = gets.chomp

    train = get_obj_by_type_and_name(Train, train_number)
    station = get_obj_by_type_and_name(Station, station_name)

    train.specify_current_station(station)
  end

  def remove_wagon_from_train
    puts 'Enter wagon id'
    wagon_id = gets.chomp

    puts 'Enter train number'
    train_number = gets.chomp

    train = get_obj_by_type_and_name(Train, train_number)
    wagon = get_obj_by_type_and_name(Wagon, wagon_id)
    train.remove_wagon(wagon)
  end

  def add_wagon_to_train
    puts 'Enter wagon id'
    wagon_id = gets.chomp

    puts 'Enter train number'
    train_number = gets.chomp

    train = get_obj_by_type_and_name(Train, train_number)
    wagon = get_obj_by_type_and_name(Wagon, wagon_id)
    train.add_wagon(wagon)
  end

  def create_wagon
    puts 'Enter wagon id'
    id = gets.chomp
    puts 'Enter wagon type or skip to set default'
    wagon_type = gets.chomp
    puts 'Enter weight'
    wagon_weight = gets.chomp.to_i
    puts 'Enter price'
    wagon_price = gets.chomp.to_i

    wagon = nil
    case wagon_type
    when 'cargo'
      wagon = CargoWagon.new(id, wagon_weight, wagon_price)
    when 'passenger'
      wagon = PassengerWagon.new(id, wagon_weight, wagon_price)
    when ''
      wagon = Wagon.new(id, wagon_weight, wagon_price)
    else
      puts 'Invalid wagon'
    end

    @objects << wagon unless wagon.nil?
  end

  def create_train
    puts 'Enter train number'
    train_number = gets.chomp

    puts 'Enter train type or skip for base train'
    train_type = gets.chomp

    train = nil
    case train_type
    when 'cargo'
      train = CargoTrain.new(train_number, train_type)
    when 'passenger'
      train = PassengerTrain.new(train_number, train_type)
    when ''
      train = Train.new(train_number, train_type)
    else
      puts 'Invalid train'
    end

    @objects << train unless train.nil?
  end

  def create_station
    puts 'Enter station name:'
    station_name = gets.chomp
    @objects << Station.new(station_name)
  end

  COMMANDS = {
    1 => :create_station,
    2 => :create_train,
    3 => :create_wagon,
    4 => :add_wagon_to_train,
    5 => :remove_wagon_from_train,
    6 => :move_train_to_station,
    7 => :list_all_stations,
    8 => :list_of_trains_on_station
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
    8 list of trains on station'

    loop do
      # puts @objects
      puts 'Enter command'
      command = gets.chomp.to_i
      send COMMANDS[command]
    end
  end
end

Main.new.start
