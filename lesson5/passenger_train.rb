# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def self.find(train_name)
    s = super(train_name)
    
    s.type == 'cargo' ? nil : s
  end

  def add_wagon(wagon)
    super(wagon) if wagon.instance_of?(PassengerWagon)
  end
end
