class Hangman
    attr_accessor :name, :attempts
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
end
game = Hangman.new("sahil")
puts game.name
game.display