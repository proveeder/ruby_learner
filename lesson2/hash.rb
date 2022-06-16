# frozen_string_literal: true

# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

puts %w[a e o u i].map { |vowel| [vowel, ('a'..'z').to_a.index(v)+1].to_h}
