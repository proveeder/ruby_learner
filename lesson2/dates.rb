# frozen_string_literal: true

# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). Найти порядковый номер даты,
# начиная отсчет с начала года. Учесть, что год может быть високосным.

months_and_days = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31,
                    9 => 30, 10 => 31, 11 => 30, 12 => 31 }

puts 'Enter day, month and year'

day = gets.chomp.to_i
month = gets.chomp.to_i
year = gets.chomp.to_i

# validation
input_valid = (1..31).include?(day) && (1..12).include?(month) && year.positive?

if input_valid
  res = 0

  # add days in past months
  (1..month - 1).each { |m| res += months_and_days[m] }

  # add days of current month if days input is valid
  res += day if months_and_days[month] >= day

  # if year is leap add 1 more day for february
  if (year % 4).zero? && (year % 100).zero? && (year % 400).zero? && res >= months_and_days[1] + months_and_days[2]
    res += 1
  end

  puts res
else
  puts 'Invalid input'
end
