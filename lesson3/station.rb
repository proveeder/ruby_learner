# frozen_string_literal: true

# Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может показывать список всех поездов на станции, находящиеся в текущий момент
# Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
class Station
  attr_reader :name, :trains_on_station

  def initialize(station_name)
    @name = station_name
    @trains_on_station = []
  end

  def add_train_to_station(train)
    trains_on_station.push(train) if train.instance_of?(Train)
  end

  def trains_on_station_by_type(train_type)
    trains_on_station_by_type = []
    amount = 0

    trains_on_station.each do |train|
      amount += 1 if train.type == train_type
      trains_on_station_by_type.push(train.number)
    end

    puts "Trains of type #{train_type} on station: #{trains_on_station_by_type}. Amount: #{amount}"
  end
end
