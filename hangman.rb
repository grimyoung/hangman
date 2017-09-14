def random_word(file_location)
  word_bank = []
  dictionary = File.open(file_location)
  dictionary.each_line do |line|
    line = line.chomp
    if line.length > 4 && line.length < 13
      word_bank << line
    end
  end
  return word_bank[rand(word_bank.length)]
end



def save_game
end

def load_game
end

