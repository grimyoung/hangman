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

def check_guess(solution, guess, correct_guesses, wrong_guesses)
  match = false
  solution.each_char.with_index do |char, i|
    if char == guess
      correct_guesses[i] = solution[i]
      match = true
    end
  end
  if ! match
    wrong_guesses << guess
    puts "Incorrect!"
  else
    puts "Correct!"
  end
  return correct_guesses, wrong_guesses
end

#to save need to save the correct_guesses and solutions
#probably need to rewrite game to either take the loaded in guesses and solution
#or generate a new solution from the provided dictionary
def save_game
end


#need to figure out how to list all available files in a directory
def load_game
end


#need to rewrite game (or make a "play" method)
#so that it can either do a new game or load a save game
def game(word_bank_file)
  solution = random_word(word_bank_file)
  correct_guesses = input_placeholder(solution)
  wrong_guesses = []
  chances = 5
  puts solution, correct_guesses, wrong_guesses, chances
  while ! game_over?(solution,correct_guesses) && wrong_guesses.length < chances
    letter = get_input
    puts
    if correct_guesses.include?(letter) || wrong_guesses.include?(letter)
      puts "You've already guessed that"
    else 
      correct_guesses, wrong_guesses = check_guess(solution, letter, correct_guesses, wrong_guesses)
      print_word(correct_guesses)
      puts "Misses: " + wrong_guesses.join(",")
    end  
    puts
  end
  if game_over?(solution,correct_guesses)
    puts "Congratulations! Word Solved."
  else
    puts "Too bad! The correct word was " + solution
  end
  puts
end

game("5desk.txt")

