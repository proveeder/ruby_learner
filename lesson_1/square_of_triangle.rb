# frozen_string_literal: true

# Площадь треугольника можно вычилсить, зная его основание (a) и высоту (h) по формуле: 1/2*a*h.
# Программа должна запрашивать основание и высоту треугольника и возвращать его площадь.

puts 'Enter a:'
a = gets.chomp.to_i

puts 'Enter h:'
h = gets.chomp.to_i

if a.positive? && h.positive?
  square = (1.0 / 2.0) * a * h
  puts "Triangle square: #{square}"
end
