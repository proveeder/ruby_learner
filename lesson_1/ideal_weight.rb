=begin
  Программа запрашивает у пользователя имя и рост и выводит идеальный вес по формуле <рост> - 110, после чего выводит
  результат пользователю на экран с обращением по имени. Если идеальный вес получается отрицательным, то выводится строка
  "Ваш вес уже оптимальный"
=end

puts "Enter your name"
name = gets.chomp

puts "Enter your height"
height = gets.chomp.to_i

ideal_weight = height - 110

if ideal_weight < 0
  puts "#{name}, your weight is already optimal"
else
  puts "#{name}, your ideal weight is #{ideal_weight}"
end
