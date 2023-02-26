# hangman
Hangman game from TOP Ruby course

This Hangman game is played in the terminal. The program loads a list of 10,000 words from an external file and randomly chooses one of them between 5-12 words for the player to guess. The player has 6 wrong guesses before they lose the game. Every turn, an updated array prints to the screen displaying which letters the player has guessed correctly so far. Once the player has guessed a letter, it is removed from the list of valid choices, so it cannot be guessed twice.

Here is the word list I used for this game: https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt. I downloaded the file and added it to my project folder to have my program read from it.

The game can be saved and returned to at any point. If the player types "save" instead of entering a letter, the program prompts the player to provide a name for their save file. The current game state is then serialized using YAML. When the player returns to re-open the YAML file later, it picks up at exactly the same point where the game left off. 

This was fun to make and fun to play. :)