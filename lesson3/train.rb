# frozen_string_literal: true

# Класс Train (Поезд):
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при
# создании экземпляра класса
# Может набирать скорость
# Может показывать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может показывать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество
# вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route)
# Может перемещаться между станциями, указанными в маршруте.
# Показывать предыдущую станцию, текущую, следующую, на основе маршрута
class Train
  attr_reader :speed, :number_of_wagons, :type, :number

  def initialize(train_number, train_type, number_of_wagons)
    @number = train_number ? train_number.instance_of?(String) : nil
    @type = train_type ? %w[freight passenger].include?(train_type) : nil
    @number_of_wagons = number_of_wagons ? number_of_wagons.positive? : 0
    @speed = 0
    @route = nil
    @current_station = nil
  end

  def speed=(extra_speed)
    @speed += extra_speed if @speed + extra_speed >= 0
  end

  def add_wagon
    if @speed.zero?
      @number_of_wagons += 1
    else
      puts "Train is moving, can't add wagons"
    end
  end

  def remove_wagon
    if @speed.zero?
      @number_of_wagons -= 1
    else
      puts "Train is moving, can't remove wagons"
    end
  end

  def add_route(route)
    @route = route ? route.instance_of?(Route) : puts('Invalid route')
  end

  def change_current_station(station)
    @current_station = station if station.instance_of?(Station) && !@route.nil? && @route.all_stations.include(station)
  end
end
