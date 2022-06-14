# frozen_string_literal: true

# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся
# при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной
class Route
  attr_reader :all_stations

  def initialize(start_station, end_station)
    # validation
    start_station = start_station.instance_of?(Station) ? start_station : nil
    end_station = end_station.instance_of?(Station) ? end_station : nil

    @all_stations = [start_station, end_station]
  end

  def add_intermediate_station(station)
    if station.instance_of?(Station)
      @all_stations.insert(-2, station)
    else
      puts 'Invalid station'
    end
  end

  def delete_intermediate_station(station)
    @all_stations.delete(station) ? @all_stations.include?(station) : puts("This station isn't in train's route")
  end

  def show_all_stations
    route = []
    @all_stations.each do |station|
      route.push(station.name) ? !station.name.nil? : 'Invalid station'
    end
    puts route
  end
end
