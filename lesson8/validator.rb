module Validator

  # classmethod
  def validate(name, validation_type, **params)
    value = instance_variable_get("@#{name}")
    case validation_type
    when :presence
      value.nil? || value == '' ? false : true
      # define_method
    when :format
      regex = params[:pattern]
      value =~ regex ? true : false
      # define_method @
    when :type
      type = params[:class]
      value.instance_of?(type)
      # define_method
    else
      puts 'Error on validation type'
    end
  end

  # instance
  def validate!
  end

  def valid?
    instance_variable_get.each { || }
  end
end
