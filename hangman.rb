def random_word(word_bank_file)
  word_bank = []
  dictionary = File.open(word_bank_file)
  dictionary.each_line do |line|
    line = line.chomp
    if line.length > 4 && line.length < 13
      word_bank << line
    end
  end
  return word_bank[rand(word_bank.length)].downcase
end

def input_placeholder(word)
  string = "_" * word.length
  return string
end

def print_word(word)
  puts word.chars.join(" ")
end

def game_over?(solution, guess)
  if solution == guess
    return true
  else
    return false
  end
end

def get_input
  input = ""
  puts "Please enter a letter: "
  loop do
    input = gets.chomp.downcase
    alphabetic = input.match(/^[[:alpha:]]$/)
    break if input.length == 1 && alphabetic
    if input.length != 1
      puts "Please enter one letter at a time"
    elsif not alphabetic
      puts "Please enter alphabetic characters only"
    end
  end
  return input
end

def check_guess(solution, guess, correct_guesses)
  solution.each_char.with_index do |char, i|
    if char == guess
      correct_guesses[i] = solution[i]
    end
  end
  return correct_guesses
end


def save_game
end

def load_game
end

def game(word_bank_file)
  solution = random_word(word_bank_file)
  correct_guesses = input_placeholder(solution)


  letter = get_input

  correct_guesses = check_guess(solution, letter, correct_guesses)
  print_word(correct_guesses)



end

game("5desk.txt")

