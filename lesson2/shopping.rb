# frozen_string_literal: true

# Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара
# (может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп"
# в качестве названия товара. На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, содержащий
# цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

answers = {}

loop do
  puts 'Enter product'
  product = gets.chomp.to_s
  break if product == 'стоп'

  puts 'Enter price'
  price = gets.chomp.to_f
  puts 'Invalid price' && next unless price.positive?

  puts 'Enter quantity'
  quantity = gets.chomp.to_i
  puts 'Invalid quantity' && next unless quantity.positive?

  answers[product] = { price: price, quantity: quantity }
end

puts answers

product_and_sum = {}
all_sum = 0
answers.each do |product, info|
  spend_for_this_item = info[:price] * info[:quantity]
  product_and_sum[product] = spend_for_this_item

  all_sum += spend_for_this_item
end

puts product_and_sum, all_sum
