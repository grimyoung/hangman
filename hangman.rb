class Hangman
  attr_accessor :solution, :correct_guesses, :wrong_guesses

  def initialize(word_bank_file = "5desk.txt", options = {})
    if options.empty?
      @solution = random_word(word_bank_file)
      @correct_guesses = input_placeholder(solution)
      @wrong_guesses = []
    else
      @solution = options["solution"]
      @correct_guesses = options["correct_guesses"]
      @wrong_guesses = options["wrong_guesses"]
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
      break if input.length == 1 && alphabetic || input = "save"
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
    end
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

  #need to move save_game and load_game outside of hangman.rb
  def save_game
    filename = Dir.entries("saved_games").length.to_s + ".txt"
    save_file = File.open(filename, "w")
    savefile.puts solution
    savefile.puts correct_guesses
    savefile.puts wrong_guesses
    savefile.close
  end


  #need to figure out how to list all available files in a directory
  def load_game
  end


  #need to rewrite game (or make a "play" method)
  #so that it can either do a new game or load a save game
  def game
    chances = 5
    puts solution, correct_guesses, wrong_guesses, chances
    while ! game_over? && wrong_guesses.length < chances
      letter = get_input
      puts
      if letter == save
        confirm_save
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

Hangman.new("5desk.txt").game