# frozen_string_literal: true

require_relative 'wagon'

class CargoWagon < Wagon

  attr_reader :volume_available

  def initialize(name, volume)
    super(name)
    @total_volume = volume
    @volume_available = volume
  end

  def taken_volume
    @total_volume - @volume_available
  end

  def change_volume(volume)
    if @volume_available + volume >= 0 && @volume_available + volume <= @total_volume
      @volume_available += volume
    else
      puts('Can\'t change volume')
    end
  end

  def default_weight
    1000
  end

  def default_price
    50 * 1000
  end
end
