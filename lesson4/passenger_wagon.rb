# frozen_string_literal: true

class PassengerWagon < Wagon
  def default_weight
    2000
  end

  protected

  def default_price
    150 * 1000
  end
end

