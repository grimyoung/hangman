class Hangman
  attr_accessor :solution, :correct_guesses, :wrong_guesses, :load_file, :loaded

  def initialize(load = "dictionary", load_file = "5desk.txt")
    if load == "dictionary"
      @solution = random_word(load_file)
      @correct_guesses = input_placeholder(solution)
      @wrong_guesses = []
    else
      @loaded = true
      @load_file = load_file
      game_state = load_game(load_file)
      @solution = game_state[0]
      @correct_guesses = game_state[1]
      @wrong_guesses = game_state[2].split(",")
      puts "File "+ load_file + " Loaded"
      print_word(correct_guesses)
      puts "Misses: " + wrong_guesses.join(",")
      puts
    end
  end

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

  def game_over?
    if solution == correct_guesses
      return true
    else
      return false
    end
  end

  def get_input
    input = ""
    puts "Please enter a letter or type 'save' to save game:"
    loop do
      input = gets.chomp.downcase
      alphabetic = input.match(/^[[:alpha:]]$/)
      break if input.length == 1 && alphabetic || input == "save"
      if input.length != 1
        puts "Please enter one letter at a time"
      elsif not alphabetic
        puts "Please enter alphabetic characters only"
      end
    end
    return input
  end

  def confirm_save
    puts "Do you wish to save? Type 'y' or 'n'"
    input = gets.chomp.downcase
    if input == "y"
      save_game
      return true    
    end
    return false
  end



  def check_guess(guess)
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

  def save_game
    if loaded
      file_name = load_file
    else
      file_name = "saved_games/" + Dir.entries("saved_games").length.to_s + ".txt"
    end
    save_file = File.open(file_name, "w")
    save_file.puts solution
    save_file.puts correct_guesses
    save_file.puts wrong_guesses.join(",")
    save_file.close
    puts "Game Saved as " + file_name
  end

  def load_game(file_name)
    game_state = []
    File.open(file_name).readlines.each do |line|
      game_state << line.chomp
    end
    return game_state
  end

  def game
    chances = solution.length - 2
    #puts solution, correct_guesses, wrong_guesses, chances
    while ! game_over? && wrong_guesses.length < chances
      letter = get_input
      puts
      if letter == "save"
        saved = confirm_save
        if saved
          puts
          return
        end
      else
        if correct_guesses.include?(letter) || wrong_guesses.include?(letter)
          puts "You've already guessed that"
        else 
          correct_guesses, wrong_guesses = check_guess(letter)
          print_word(correct_guesses)
          puts "Misses: " + wrong_guesses.join(",")
        end
      end
      puts
    end
    if game_over?
      puts "Congratulations! Word Solved."
    else
      puts "Too bad! The correct word was " + solution
    end
    puts
  end
end

#Hangman.new("dictionary", "5desk.txt").game()
Hangman.new("load", "saved_games/4.txt").game()