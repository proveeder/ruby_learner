# frozen_string_literal: true

# Создать модуль, который позволит указывать название компании-производителя и получать его.
module Manufacturer
  def specify_manufacturer(manufacturer)
    @manufacturer = manufacturer
  end

  def show_manufacturer
    puts @manufacturer
  end
end
