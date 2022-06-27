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
          p value
          value.nil? || value == '' ? false : true
        end
      when :format
        define_method(method_name) do
          value = instance_variable_get("@#{name}")
          regex = params[:pattern]
          value =~ regex ? true : false
        end
      when :type
        define_method(method_name) do
          value = instance_variable_get("@#{name}")
          type = params[:class]
          value.instance_of?(type)
        end
      else
        puts 'Error on validation type'
      end
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |method|
        p method
        raise RuntimeError if (send method) == false
      end
    end

    def valid?
      validation_methods = methods.filter { |method| method =~ /^[a-z]*_[a-z]*_validate$/ }
      res = true
      validation_methods.each do |method|
        res = send method
        break if res == false
      end
      res
    end
  end
end
