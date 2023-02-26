require "yaml"

class Game
  
  def initialize
    @DICTIONARY = File.read("google-10000-english-no-swears.txt").split("\n")
    @secret_word = choose_secret_word.split("")
    @letters_available = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
                          "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
                          "u", "v", "w", "x", "y", "z"]
    @guess = []
    @wrong_guesses_left = 6
    puts "Hi! Welcome to my Hangman game."
    print_hangman
    puts "\n"
    puts "Your word to guess is #{@secret_word.length} letters long."
    puts "If you would like to save the game at any point,"
    puts "type \"save\" when the program prompts you to enter a letter."
  end
  
  #Randomly chooses a word 5-12 letters long from the dictionary.
  def choose_secret_word
    secret_word = @DICTIONARY.sample
    while secret_word.length < 5 || secret_word.length > 12
      secret_word = @DICTIONARY.sample
    end
    return secret_word
  end

  def play

    while @wrong_guesses_left > 0
      print_guess_array
      letter = guess_letter
      until @letters_available.include?(letter)
        letter = guess_letter
      end
      is_letter_in_word(letter)
      if @guess.join("").gsub(" ", "") == @secret_word.join("")
        puts "You win! You guessed the word correctly."
        puts @guess.join("")
        break
      end
    end

    if @wrong_guesses_left == 0
      print_hangman
      puts "You are out of guesses. Better luck next time!"
      puts "The word was #{@secret_word.join("")}."
    end

  end

  #Prints out the array that represents the player's guess
  def print_guess_array
    if @guess.empty?
      i = 0
      while i < @secret_word.length
        @guess[i] = "_ "
        i += 1
      end
    end
    puts @guess.join
  end

  #Gets a guess from the player.
  def guess_letter
    puts "\n"
    puts "Available letters: #{@letters_available.join(" ")}"
    puts "Guess a letter: "
    letter = gets.chomp.downcase
    if letter == "save"
      save_game
      return
    else
      until @letters_available.include?(letter)
        puts "Invalid input, please try again: "
        letter = gets.chomp.downcase
      end
    end
    return letter
  end

  #Tests whether the letter guessed is in the secret word.
  def is_letter_in_word(letter)
    if @secret_word.include?(letter)
      fill_in_blanks(letter)
    else
      puts "\"#{letter}\" is not in the secret word."
      @wrong_guesses_left -= 1
      print_hangman
    end
    @letters_available.delete(letter)
  end

  #Fills in the letter in the correct spots in the guess array.
  def fill_in_blanks(letter)
    @secret_word.each_with_index do |let, ind|
      if let == letter
        @guess[ind] = "#{letter} "
      end
    end
  end

  #Prints the hangman to the screen.
  def print_hangman
    if @wrong_guesses_left == 6
      puts " ______"
      puts " |    |"
      puts " |     "
      puts " |     "
      puts " |     "
      puts "_|_    "
    elsif @wrong_guesses_left == 5
      puts " ______"
      puts " |    |"
      puts " |    O"
      puts " |     "
      puts " |     "
      puts "_|_    "
      puts "\n"
    elsif @wrong_guesses_left == 4
      puts " ______"
      puts " |    |"
      puts " |    O"
      puts " |    |"
      puts " |     "
      puts "_|_    "
      puts "\n"
    elsif @wrong_guesses_left == 3
      puts " ______"
      puts " |    |"
      puts " |    O"
      puts " |   /|"
      puts " |     "
      puts "_|_    "
      puts "\n"
    elsif @wrong_guesses_left == 2
      puts " ______"
      puts " |    |"
      puts " |    O"
      puts " |   /|\\"
      puts " |     "
      puts "_|_    "
      puts "\n"
    elsif @wrong_guesses_left == 1
      puts " ______"
      puts " |    |"
      puts " |    O"
      puts " |   /|\\"
      puts " |   / "
      puts "_|_    "
      puts "\n"
    else
      puts " ______"
      puts " |    |"
      puts " |    O"
      puts " |   /|\\"
      puts " |   / \\"
      puts "_|_    "
      puts @guess.join("")
    end
  end

  #Writes the current game state to a yaml file named by the player
  def save_game
    puts "What do you want to name your save file?"
    file_name = gets.chomp
    saved_game = File.open("#{file_name}.yml", "w") { |file| file.write(self.to_yaml)}
  end

end

play_again = "Y"
while play_again == "Y"

  puts "Would you like to load a previously saved game?"
  puts "Enter Y for yes. Enter N to start a new game."
  load_choice = gets.chomp.upcase
  until load_choice == "Y" || load_choice == "N"
    puts "Invalid input, please try again:"
    load_choice = gets.chomp.upcase
  end

  if load_choice == "Y"
    begin
      puts "Enter the name of the saved game file you want to open."
      saved_file_name = gets.chomp    
      new_game = YAML::load(File.read("#{saved_file_name}.yml"), permitted_classes: [Game] )
      new_game.print_hangman
      new_game.play
    rescue
      puts "Sorry, I couldn't find that file."
    end
  end

  if load_choice == "N"
    new_game = Game.new
    new_game.play
  end

puts "Would you like to play again? Y/N"
play_again = gets.chomp.upcase
end
