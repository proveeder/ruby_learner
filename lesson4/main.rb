# frozen_string_literal: true

require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'station'

def create_train(objects)
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

  objects << train unless train.nil?
end

def create_station(objects)
  puts 'Enter station name:'
  station_name = gets.chomp
  objects << Station.new(station_name)
end

def get_object_by_type(objects, cls)
  objects.select { |obj| obj.class <= cls }
end

def get_obj_by_type_and_name(objects, cls, name)
  objects = get_object_by_type(objects, cls)
  objects.select { |o| o.name == name }[0]
end

def list_of_trains_on_station(objects)
  puts 'Enter station name'
  station_name = gets.chomp

  station = get_obj_by_type_and_name(objects, Station, station_name)
  puts station.trains_on_station
end

def list_all_stations(objects)
  stations = get_object_by_type(objects, Station)
  stations.each { |station| puts(station.name) }
end

def move_train_to_station(objects)
  puts 'Enter train number'
  train_number = gets.chomp

  puts 'Enter station name'
  station_name = gets.chomp

  train = get_obj_by_type_and_name(objects, Train, train_number)
  station = get_obj_by_type_and_name(objects, Station, station_name)

  train.specify_current_station(station)
end

def remove_wagon_from_train(objects)
  puts 'Enter wagon id'
  wagon_id = gets.chomp

  puts 'Enter train number'
  train_number = gets.chomp

  train = get_obj_by_type_and_name(objects, Train, train_number)
  wagon = get_obj_by_type_and_name(objects, Wagon, wagon_id)
  train.remove_wagon(wagon)
end

def add_wagon_to_train(objects)
  puts 'Enter wagon id'
  wagon_id = gets.chomp

  puts 'Enter train number'
  train_number = gets.chomp

  train = get_obj_by_type_and_name(objects, Train, train_number)
  wagon = get_obj_by_type_and_name(objects, Wagon, wagon_id)
  train.add_wagon(wagon)
end

def create_wagon(objects)
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

  objects << wagon unless wagon.nil?
end

def list_trains_on_station(objects)
  puts 'Enter station name'
  station_name = gets.chomp

  station = get_obj_by_type_and_name(objects, Station, station_name)
  puts station.trains_on_station
end

puts 'Commands:
    - create station
    - create train
    - create wagon
    - add wagon to train
    - remove wagon from train
    - move train to station
    - list all stations
    - list of trains on station
    - stop'

objects = []
loop do
  puts 'Enter command'
  answer = gets.chomp
  break if answer == 'stop'

  # to hash
  create_station(objects) if answer == 'create station'
  create_train(objects) if answer == 'create train'
  create_wagon(objects) if answer == 'create wagon'
  add_wagon_to_train(objects) if answer == 'add wagon to train'
  remove_wagon_from_train(objects) if answer == 'remove wagon from train'
  list_all_stations(objects) if answer == 'list all stations'
  list_of_trains_on_station(objects) if answer == 'list of trains on station'
  move_train_to_station(objects) if answer == 'move train to station'
  list_trains_on_station(objects) if answer == 'trains on station'
end

