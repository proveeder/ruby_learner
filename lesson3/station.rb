# frozen_string_literal: true

# Класс Station (Станция):
class Station
  # Может показывать список всех поездов на станции, находящиеся в текущий момент
  attr_reader :name, :trains_on_station

  def initialize(station_name)
    # Имеет название, которое указывается при ее создании
    @name = station_name.instance_of?(String) ? station_name : nil
    @trains_on_station = []
  end

  # Может принимать поезда (по одному за раз)
  def take_train(train)
    trains_on_station.push(train) if train.instance_of?(Train)
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def send_train(train)
    trains_on_station.delete(train) if train.instance_of?(Train)
  end

  # Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def trains_on_station_by_type(train_type)
    trains_on_station_by_type = @trains_on_station.select { |train| train.type == train_type }

    puts "Trains of type #{train_type} on station: #{trains_on_station_by_type}.
          Amount: #{trains_on_station_by_type.length}"
  end
end
