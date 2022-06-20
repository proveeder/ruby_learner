# frozen_string_literal: true

# Класс Route (Маршрут):
class Route
  # Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся
  # при создании маршрута, а промежуточные могут добавляться между ними.
  def initialize(start_station, end_station)
    @start_station = start_station.instance_of?(Station) ? start_station : nil
    @end_station = end_station.instance_of?(Station) ? end_station : nil
    @intermediate_stations = []

    validate!
  end

  # Может добавлять промежуточную станцию в список
  def add_intermediate_station(station)
    @intermediate_stations.push(station) if station.instance_of?(Station)
  end

  # Может удалять промежуточную станцию из списка
  def delete_intermediate_station(station)
    @intermediate_stations.delete(station) if @intermediate_stations.include?(station)
  end

  def all_stations
    [@start_station] + @intermediate_stations + [@end_station]
  end

  # Может выводить список всех станций по-порядку от начальной до конечной
  def show_all_stations
    puts all_stations
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    raise 'Start station must be instance of Station class' unless @start_station.instance_of?(Station)
    raise 'End station must be instance of Station class' unless @end_station.instance_of?(Station)
  end
end
