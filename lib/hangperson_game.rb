class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses=''
    @wrong_guesses=''
  end
  
  attr_accessor :word,:guesses, :wrong_guesses

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(a_guess)
    # first check if it's a valid guess
    # must be a letter and non-empty
    if a_guess == nil
      raise ArgumentError.new("not a valid guess")
    end
    if a_guess.length != 1
      raise ArgumentError.new("not a valid guess")
    end
    if !(a_guess =~ /[A-Za-z]/)
      raise ArgumentError.new("not a valid guess")
    end  
    # check everything against a lower case string
    word_lower = @word.downcase
    # also change guess to lower case
    a_guess_lower = a_guess.downcase
    # first check if the guess has already been made
    if !(@guesses.include? a_guess_lower)&& !(@wrong_guesses.include? a_guess_lower)
      if word_lower.include? a_guess_lower
        @guesses += a_guess_lower
      else
        @wrong_guesses += a_guess_lower
      end
      return true
    else
      return false    
    end
  end
  
  def word_with_guesses
    display=''
    @word.chars do |letter|
      if @guesses.include? letter.downcase
        display += letter
      else
        display += '-'
      end
    end
    return display
  end

end

garp = HangpersonGame.new('garply')

garp.guess('A')
garp.guess('a')
garp.guess('Q')
garp.guess('q')
garp.guess('p')
puts '1) ' + garp.guesses
puts garp.wrong_guesses
puts garp.word_with_guesses
