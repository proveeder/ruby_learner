# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def add_wagon(wagon)
    super(wagon) if wagon.instance_of?(PassengerWagon)
  end
end
