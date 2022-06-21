# frozen_string_literal: true

require_relative 'validation'

# Класс Station (Станция):
class Station
  # Может показывать список всех поездов на станции, находящиеся в текущий момент
  attr_reader :name, :trains_on_station

  include Validation

  def initialize(station_name)
    # Имеет название, которое указывается при ее создании
    @name = station_name.instance_of?(String) ? station_name : nil
    @trains_on_station = []

    Validation.validate_name!(@name)
  end

  def self.do_for_each_train(&block)
    ObjectSpace.each_object(Station).to_a.each do |station|
      station.trains_on_station.each(&block)
    end
  end

  # Может принимать поезда (по одному за раз)
  def take_train(train)
    trains_on_station.push(train) if train.class <= Train
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def send_train(train)
    trains_on_station.delete(train) if train.class <= Train
  end

  # В классе Station (жд станция) создать метод класса all, который возвращает все станции (объекты),
  # созданные на данный момент
  def self.all
    ObjectSpace.each_object(self).to_a.each { |station| puts station.name }
  end

  def valid?
    Validation.validate_name!(@name)
  rescue StandardError
    false
  end
end
