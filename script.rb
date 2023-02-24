class Game
  
  def initialize
    @DICTIONARY = File.read("google-10000-english-no-swears.txt").split("\n")
    @secret_word = choose_secret_word.split("")
    @letters_available = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
                          "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
                          "u", "v", "w", "x", "y", "z"]
    @wrong_guesses_left = 6
    puts "Hi! Welcome to my Hangman game."
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
    print_hangman
    puts "\n"
    puts "Your word to guess is #{@secret_word.length} letters long."
    make_guess_array

    while @wrong_guesses_left > 0
      letter = guess_letter
      is_letter_in_word(letter)
      if @guess.join("").gsub(" ", "") == @secret_word.join("")
        puts "You win! You guessed the word correctly."
        break
      end
    end

    if @wrong_guesses_left == 0
      print_hangman
      puts "You are out of guesses. Better luck next time!"
      puts "The word was #{@secret_word.join("")}."
    end

  end

  #Makes a new empty array to be filled in as the player guesses letters.
  def make_guess_array
    @guess = Array.new(@secret_word.length)
    i = 0
    while i < @secret_word.length
      @guess[i] = "_ "
      i += 1
    end
    puts @guess.join
  end

  #Gets a guess from the player.
  def guess_letter
    puts "\n"
    puts "Available letters: #{@letters_available.join(" ")}"
    puts "Guess a letter: "
    letter = gets.chomp.downcase
    until @letters_available.include?(letter)
      puts "Invalid input, please try again: "
      letter = gets.chomp.downcase
    end
    return letter
  end

  #Tests whether the letter guessed is in the secret word.
  def is_letter_in_word(letter)
    if @secret_word.include?(letter)
      fill_in_blanks(letter)
    else
      puts "\"#{letter}\" is not included in the secret word."
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
    puts @guess.join("")
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
      puts @guess.join("")
    elsif @wrong_guesses_left == 4
      puts " ______"
      puts " |    |"
      puts " |    O"
      puts " |    |"
      puts " |     "
      puts "_|_    "
      puts "\n"
      puts @guess.join("")
    elsif @wrong_guesses_left == 3
      puts " ______"
      puts " |    |"
      puts " |    O"
      puts " |   /|"
      puts " |     "
      puts "_|_    "
      puts "\n"
      puts @guess.join("")
    elsif @wrong_guesses_left == 2
      puts " ______"
      puts " |    |"
      puts " |    O"
      puts " |   /|\\"
      puts " |     "
      puts "_|_    "
      puts "\n"
      puts @guess.join("")
    elsif @wrong_guesses_left == 1
      puts " ______"
      puts " |    |"
      puts " |    O"
      puts " |   /|\\"
      puts " |   / "
      puts "_|_    "
      puts "\n"
      puts @guess.join("")
    else
      puts " ______"
      puts " |    |"
      puts " |    O"
      puts " |   /|\\"
      puts " |   / \\"
      puts "_|_    "
    end
  end
end

new_game = Game.new
new_game.play
