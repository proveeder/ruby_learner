module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :amount_instances

    def instances
      amount_instances || 0
    end
  end

  module InstanceMethods
    private

    def register_instance
      amount_instances = self.class.amount_instances || 0
      self.class.amount_instances = amount_instances + 1
    end
  end
end

class A
  include InstanceCounter

  def initialize
    register_instance
  end
end

A.new
p A.instances

# check if private
p A.new.respond_to?(:register_instance)

p A.instances
