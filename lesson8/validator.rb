module Validator
  def validate(name, validation_type, **params)
    value = instance_variable_get("@#{name}")
    case validation_type
    when :presence
      value.nil? || value == '' ? false : true
    when :format
      regex = params[:pattern]
      value =~ regex ? true : false
    when :type
      type = params[:class]
      value.instance_of?(type)
    else
      puts 'Error on validation type'
    end
  end
end
