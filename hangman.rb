class Hangman
    attr_accessor :name, :attempts, :attempts
    @@vowel = "aeiouAEIOU"
    def initialize(name)
        @name = name
        @secret_word = generateword()
        @attempts = 5
    end

    def generateword
        raw_data = File.readlines("5desk.txt")
        data = raw_data.select{|word|word.length>5 && word.length<12}
        len = data.length
        return data[rand(len)]
    end

    def display
        @secret_word.split("").each do |letter|
          if @@vowel.include?(letter)
            print letter
          else
              print " _ "
          end
        end
        puts ""
    end
    
    def make_guess(guess)
        if @secret_word.include?(guess)
            puts "successful guess"
            @@vowel += guess
            self.display
        else
            puts "guess unsucssessful"
            @attempts -= 1
            puts "No of attempts remaining is #{@attempts}"
            if @attempts <= 0
                puts "ran out of attempts \n the word is #{@secret_word}"
            end
        end
    end

end
game = Hangman.new("sahil")
while (game.attempts>0)
    game.display
    puts "make your guess"
    guess = gets.chomp
    game.make_guess(guess)
end