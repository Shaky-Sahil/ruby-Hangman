class Hangman
    attr_accessor :name, :attempts, :attempts
    @@vowel = "aeiouAEIOU"
    def initialize(name)
        @name = name
        @secret_word = generateword().strip
        @attempts = 5
    end

    def generateword
        raw_data = File.readlines("5desk.txt")
        data = raw_data.select{|word|word.length>5 && word.length<12}
        len = data.length
        return data[rand(len)]
    end

    def display
        display_word = ""
        @secret_word.split("").each do |letter|
          if @@vowel.include?(letter)
            display_word += letter
          else
              display_word += " _ "
          end
        end
        puts display_word
        puts ""
        return display_word
    end
    
    def make_guess(guess)
        if @secret_word.downcase.include?(guess.downcase)
            puts "successful guess"
            @@vowel += guess
            word_status = self.display
            if (! word_status.contains?("_"))
                @attempts = 6
            end
        else
            puts "guess unsucssessful"
            @attempts -= 1
            puts "No of attempts remaining is #{@attempts}"
            if @attempts <= 0
                puts "ran out of attempts \n the word is #{@secret_word}"
            elsif @attempts >5
                puts "You win!!!"
            end
        end
    end

    def save
        save_data = Marshal.dump(self)
        file = File.open("savefiles/#{@name}.txt","w")
        file.write(save_data)
        file.close
    end

    def self.load
        file_list = Dir.entries("/home/sahil/the_odin_project/ruby/projects/hangman/savefiles/")
        file_list.each{|file_name| puts file_name}
        puts "choose the save file to load"
        load_file = gets.chomp
        load_data = File.read("savefiles/#{load_file}")
        return Marshal.load(load_data)
    end
end
puts "do you want to load a savefile or start a new game"
puts "enter '1' to load a game and any other key to start a new game"
puts "Make your choice"
choice = gets.chomp
if(choice == '1')
    game = Hangman.load
else
puts "enter the new game name"
game_name = gets.chomp
game = Hangman.new(game_name)
end
while (game.attempts>0 && game.attempts<=5)
    game.display
    puts "make your guess"
    guess = gets.chomp
    game.make_guess(guess)
    puts ""
    puts "do you want to save the game? (Enter 'y' to save)"
    save_choice = gets.chomp
    if save_choice == 'y'
        game.save()
    end
end