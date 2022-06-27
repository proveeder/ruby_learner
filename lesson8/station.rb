# frozen_string_literal: true

require_relative 'validator'

# Класс Station (Станция):
class Station
  # Может показывать список всех поездов на станции, находящиеся в текущий момент

  include Validator

  validate :name, :presence
  validate :name, :type, class: Integer

  attr_accessor :name
end

st = Station.new
st.name = '1'
p st.validate!
