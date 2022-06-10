# frozen_string_literal: true

# Пользователь вводит 3 коэффициента a, b и с. Программа вычисляет дискриминант (D) и корни уравнения
# (x1 и x2, если они есть) и выводит значения дискриминанта и корней на экран. При этом возможны следующие варианты:
# Если D > 0, то выводим дискриминант и 2 корня
# Если D = 0, то выводим дискриминант и 1 корень (т.к. они в этом случае равны)
# Если D < 0, то выводим дискриминант и сообщение "Корней нет"

puts 'Enter a'
a = gets.chomp.to_i

puts 'Enter b'
b = gets.chomp.to_i

puts 'Enter c'
c = gets.chomp.to_i

discriminant = b**2 - 4 * a * c

if discriminant.negative?
  puts "I've got no roots"
elsif discriminant.zero?
  x1 = -b / 2 * a
  puts "x1 = #{x1}"
elsif discriminant.positive?
  x1 = (-b + Math.sqrt(discriminant)) / 2 * a
  x2 = (-b - Math.sqrt(discriminant)) / 2 * a
  puts "x1 = #{x1}, x2 = #{x2}"
end
