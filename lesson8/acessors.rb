module Acessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def my_attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          v = instance_variable_get("@vars_vals".to_sym) || []
          instance_variable_set("@vars_vals".to_sym, v.push({ var_name => value }))
          # @vars_vals << { var_name => value }
          # p "Value changed for #{var_name} on #{value}"
        end
        define_method("#{name}_history".to_sym) { @vars_vals.map { |x| x[var_name] } }
      end
    end

    def strong_attr_accessor(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |options|
          value = options[0]
          cls = options[1]
          if value.instance_of?(cls)
            instance_variable_set(var_name, value)
          else
            raise RuntimeError
          end
        end
      end
    end
  end
end

class A
  include Acessors

  my_attr_accessor_with_history :a, :c
  strong_attr_accessor :b
end

a = A.new
# b = A.new

# p a.a
a.a = 1
a.a = 2
p a.instance_variables

# p b.a
# b.a = 3
# b.a = 4
# p b.a_history

# a.b = [1, Integer]
# p a.b
# a.b = [1, String]
