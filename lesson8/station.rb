# frozen_string_literal: true

require_relative 'validator'

# Класс Station (Станция):
class Station
  # Может показывать список всех поездов на станции, находящиеся в текущий момент
  attr_reader :name, :trains_on_station

  include Validator
  # extend Validator

  validate :name, :presence
  validate :name, :format, /./

  def initialize(station_name)
    # Имеет название, которое указывается при ее создании
    @name = station_name.instance_of?(String) ? station_name : nil
    @trains_on_station = []

    validate!
  end

  def valid?
    validate!
    true
  end

  private

  def validate!
    raise 'Station name must be set!' unless validate(:name, :presence)
    raise 'Name must be String!' unless validate(:name, :type, class: String)
    raise 'Name must match /^[A-Z]+[a-z]+$/' unless validate(:name, :format, pattern: /^[A-Z]+[a-z]+$/)
  end
end

st = Station.new('St')

p st.valid?
