# frozen_string_literal: true

require_relative 'wagon'

class CargoWagon < Wagon
  def default_weight
    1000
  end

  def default_price
    50 * 1000
  end
end
