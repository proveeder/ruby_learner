# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def add_wagon(wagon)
    super(wagon) if wagon.instance_of?(CargoWagon)
  end
end
