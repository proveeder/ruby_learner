# frozen_string_literal: true

# Класс Train (Поезд):
# Показывать предыдущую станцию, текущую, следующую, на основе маршрута
class Train
  # Может показывать текущую скорость
  # Может показывать количество вагонов
  attr_reader :speed, :number_of_wagons, :type, :number

  # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при
  # создании экземпляра класса
  def initialize(train_number, train_type, number_of_wagons)
    @number = train_number.instance_of?(String) ? train_number : nil
    @type = %w[freight passenger].include?(train_type) ? train_type : nil
    @number_of_wagons = number_of_wagons.positive? ? number_of_wagons : 0
    @speed = 0
    @route = nil
    @current_station = nil
  end

  # Может тормозить (сбрасывать скорость до нуля)
  # Может набирать скорость
  def change_speed(extra_speed)
    @speed += extra_speed if @speed + extra_speed >= 0
  end

  # Может прицеплять вагоны (по одному вагону за операцию). Прицепка/отцепка вагонов может осуществляться только если
  # поезд не движется.
  def add_wagon
    speed.zero? ? @number_of_wagons += 1 : puts("Train is moving, can't add wagons")
  end

  # Может отцеплять вагоны (по одному вагону за операцию). Прицепка/отцепка вагонов может осуществляться только если
  # поезд не движется.
  def remove_wagon
    speed.zero? && @number_of_wagons.positive? ? @number_of_wagons -= 1 : puts("Can't remove wagons")
  end

  # Может принимать маршрут следования (объект класса Route)
  def add_route(route)
    @route = route.instance_of?(Route) ? route : puts('Invalid route')
  end

  def specify_current_station(station)
    @current_station = station if station.instance_of?(Station)
    station.take_train(self)
  end

  # make private
  def can_be_moved_to_this_station(station)
    if !@route.nil? && station.instance_of?(Station) && @route.all_stations.include?(station)
      true
    elsif @current_station == station
      puts 'Train is already on this station'
      false
    else
      false
    end
  end

  # Может перемещаться между станциями, указанными в маршруте.
  def move_to_new_station(station)
    if can_be_moved_to_this_station(station)
      @current_station&.send_train(self)
      @current_station = station
      station.take_train(self)
    end
  end
end
