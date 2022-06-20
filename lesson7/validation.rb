# frozen_string_literal: true

module Validation
  def self.validate_name!(name)
    raise "Name must be string #{name.class}" unless name.instance_of?(String)
    raise 'Name must begin with capital letter and contain only latin letters' unless name =~ /^[A-Z]+[a-z]+$/
  end
end
