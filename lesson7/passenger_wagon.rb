# frozen_string_literal: true

require_relative 'wagon'

class PassengerWagon < Wagon

  attr_reader :places_available

  def initialize(wagon_name, amount_places)
    super(wagon_name)
    @amount_places = amount_places
    @places_available = amount_places
  end

  def take_one_place
    @places_available - 1 >= 0 ? @places_available -= 1 : puts('No places available at the moment')
  end

  def free_one_place
    @places_available + 1 <= @amount_places ? @places_available += 1 : puts('Can\'t free place')
  end

  def taken_places
    @amount_places - @places_available
  end

  def default_weight
    2000
  end

  protected

  def default_price
    150 * 1000
  end
end

