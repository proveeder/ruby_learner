module Validator
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, validation_type, **params)
      case validation_type
      when :presence
        define_method("#{name}_#{validation_type}_validate") do
          value = instance_variable_get("@#{name}")
          value.nil? || value == '' ? false : true
        end
      when :format
        define_method("#{name}_#{validation_type}_validate") do
          value = instance_variable_get("@#{name}")
          regex = params[:pattern]
          value =~ regex ? true : false
        end
      when :type
        define_method("#{name}_#{validation_type}_validate") do
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
      validation_methods = methods.filter { |method| method =~ /^[a-z]*_[a-z]*_validate$/ }
      validation_methods.each do |method|
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
