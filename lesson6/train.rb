# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'validation'

# Класс Train (Поезд):
# Показывать предыдущую станцию, текущую, следующую, на основе маршрута
class Train
  # Подключить модуль к классам Вагон и Поезд
  include Manufacturer

  @@instances = []

  # Может показывать текущую скорость
  # Может показывать количество вагонов
  attr_reader :speed, :wagons, :type, :name

  # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при
  # создании экземпляра класса
  def initialize(train_name, train_number)
    @name = train_name
    @number = train_number
    @wagons = []
    @speed = 0
    @route = nil
    @current_station = nil

    @@instances << self
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  # В классе Train создать метод класса find, который принимает номер поезда (указанный при его создании) и возвращает
  # объект поезда по номеру или nil, если поезд с таким номером не найден.
  def self.find(train_name)
    @@instances.select { |i| i.name == train_name }[0]
  end

  # Может тормозить (сбрасывать скорость до нуля)
  # Может набирать скорость
  def change_speed(extra_speed)
    @speed += extra_speed if @speed + extra_speed >= 0
  end

  # Может принимать маршрут следования (объект класса Route)
  def add_route(route)
    @route = route.instance_of?(Route) ? route : puts('Invalid route')
  end

  def specify_current_station(station)
    @current_station = station if station.instance_of?(Station)
    station.take_train(self)
  end

  # Может перемещаться между станциями, указанными в маршруте.
  def move_to_new_station(station)
    if can_be_moved_to_this_station(station)
      @current_station&.send_train(self)
      @current_station = station
      station.take_train(self)
    end
  end

  # Может отцеплять вагоны (по одному вагону за операцию). Прицепка/отцепка вагонов может осуществляться только если
  # поезд не движется.
  # protected т.к. переопределяем метод
  def remove_wagon(wagon)
    speed.zero? ? @wagons.delete(wagon) : puts("Can't remove wagons")
  end

  # Может прицеплять вагоны (по одному вагону за операцию). Прицепка/отцепка вагонов может осуществляться только если
  # поезд не движется.
  # protected т.к. потом дополним валидацию на тип вагонов
  def add_wagon(wagon)
    # Wagon or any subclasses
    if wagon.class <= Wagon
      speed.zero? ? @wagons << wagon : puts("Can't add wagons")
    end
  end

  private

  def validate!
    Validation.validate_name!(@name)
    raise 'Train number must be like "1s2-cd"' unless @number =~ /^[\da-zA-Z]{3}-*[\da-zA-Z]{2}$/
  end

  def can_be_moved_to_this_station(station)
    !@route.nil? && station.instance_of?(Station) && @route.all_stations.include?(station) &&
      @current_station != station
  end
end
