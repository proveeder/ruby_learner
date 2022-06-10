# frozen_string_literal: true

# Заполнить массив числами фибоначи до 100

fibonacci_nums = [0, 1]
loop do
  next_num = fibonacci_nums[-1] + fibonacci_nums[-2]

  if next_num < 100
    fibonacci_nums << next_num
  else
    break
  end
end

puts fibonacci_nums
