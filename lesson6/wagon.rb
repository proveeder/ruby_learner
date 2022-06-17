# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'validation'

class Wagon
  # Подключить модуль к классам Вагон и Поезд
  include Validation
  include Manufacturer

  attr_reader :name

  def initialize(name, weight, price)
    @name = name
    @weight = weight
    @price = price.positive? ? price : default_price

    valid?
  end

  def valid?
    validate!
  rescue
    true
  end

  private

  def validate!
    Validation.validate_name!(@name)
    raise 'Weight must be positive number' unless @weight.instance_of?(Numeric) || !@weight.positive?
    raise 'Price must be positive number' unless @price.instance_of?(Numeric) || !@price.positive?
  end

  protected

  def generate_random_id
    ('a'..'z').to_a.sample(8).join
  end
end
