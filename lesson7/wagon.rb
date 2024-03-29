# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'validation'

class Wagon
  # Подключить модуль к классам Вагон и Поезд
  include Validation
  include Manufacturer

  attr_reader :name

  def initialize(name)
    @name = name

    valid?
  end

  def valid?
    validate!
  rescue StandardError
    true
  end

  private

  def validate!
    Validation.validate_name!(@name)
  end
end
