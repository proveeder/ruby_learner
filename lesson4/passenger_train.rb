# frozen_string_literal: true

class PassengerTrain < Train
  def add_wagon(wagon)
    super(wagon) if wagon.instance_of?(PassengerWagon)
  end
end
