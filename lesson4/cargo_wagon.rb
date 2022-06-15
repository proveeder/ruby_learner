# frozen_string_literal: true

class CargoWagon < Wagon
  def default_weight
    1000
  end

  def default_price
    50 * 1000
  end
end
