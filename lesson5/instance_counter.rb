module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # attr_accessor :validations

  # def validate(name, validation_type, **params)
  #   method_name = "#{name}_#{validation_type}_validate"
  #   self.validations ||= []
  #   self.validations.push(method_name)
  #
  #   case validation_type
  #   when :presence
  #     define_method(method_name) do
  #       value = instance_variable_get("@#{name}")
  #       value.nil? || value == '' ? "@#{name} can't be empty string or nil" : true
  #     end
  #   end
  # end
  #
  module ClassMethods
    def instances
      p instance_variable_get('@amount_instances') || 0
    end
  end

  module InstanceMethods
    private

    def register_instance
      amount_instances = self.class.instance_variable_get('@amount_instances') || 0
      self.class.instance_variable_set('@amount_instances', amount_instances + 1)
    end
  end
end

class A
  include InstanceCounter

  def initialize
    register_instance
  end
end

(1..10).to_a.each { A.new }
A.instances

a = A.new
p a.respond_to?(:register_instance)
