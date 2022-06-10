# frozen_string_literal: true

# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

hash = {}
vowels = 'aeoui'

('a'..'z').to_a.each_with_index do |char, index|
  hash[char] = index+1 if vowels.include?(char)
  puts hash
end
