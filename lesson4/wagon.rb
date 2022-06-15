# frozen_string_literal: true

class Wagon
  attr_reader :name

  def initialize(id, weight, price)
    @name = id.instance_of?(String) ? id : generate_random_id
    @weight = weight.positive? ? weight : default_weight
    @price = price.positive? ? price : default_price
  end

  protected

  def default_weight
    1500
  end

  def default_price
    100 * 1000
  end

  def generate_random_id
    ('a'..'z').to_a.sample(8).join
  end
end
