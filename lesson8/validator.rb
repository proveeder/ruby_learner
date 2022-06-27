module Validator
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, validation_type, **params)
      method_name = "#{name}_#{validation_type}_validate"
      self.validations ||= []
      self.validations.push(method_name)

      case validation_type
      when :presence
        define_method(method_name) do
          value = instance_variable_get("@#{name}")
          value.nil? || value == '' ? "@#{name} can't be empty string or nil" : true
        end
      when :format
        define_method(method_name) do
          value = instance_variable_get("@#{name}")
          regex = params[:pattern]
          value =~ regex ? true : "@#{name} does not match pattern #{regex}"
        end
      when :type
        define_method(method_name) do
          value = instance_variable_get("@#{name}")
          type = params[:class]
          value.instance_of?(type) ? true : "@#{name} does not match type #{type}"
        end
      else
        puts 'Error on validation type'
      end
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |method|
        res = send method
        raise res if res != true
      end
    end

    def valid?
      res = nil
      self.class.validations.each do |method|
        res = send method
        break if res != true
      end
      res
    end
  end
end
