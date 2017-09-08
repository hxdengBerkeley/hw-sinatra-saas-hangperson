class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

#@word #store the answer
#@guesses #store the chars user had guessed
#@wrong_guesses #store the chars user wrongly guessed
#@word_with_guesses
#@check_win_or_lose
  # Return the word of HangpersonGame
  def word
    return @word
  end
  # Return the guesses of HangpersonGame
  def guesses
    return @guesses
  end
  # Return the guesses of HangpersonGame
  def wrong_guesses
    return @wrong_guesses
  end
  # guess word once a letter
  def guess(char)
    if char==''||!(char=~/[A-Za-z]/)
      raise ArgumentError
    else
      char = char.downcase
      if @guesses.include?(char)||@wrong_guesses.include?(char)
        return false
      else
        if @word.include?(char)
          @guesses+=char
          for i in 0..@word.length-1
            if @word[i]==char
              @word_with_guesses[i]=char
            end
          end
          if !@word_with_guesses.include?('-')
            @check_win_or_lose=:win
          end
        else
          @wrong_guesses+=char
          if @wrong_guesses.length>=7
            @check_win_or_lose=:lose
          end
        end
        return true
      end
    end
  end
  
  # return word_with_guesses
  def word_with_guesses
    return @word_with_guesses
  end

  # check win or lose
  def check_win_or_lose
    return @check_win_or_lose
  end

  # Get a word from remote "random word" service

  # def initialize()
  def initialize()
    @word = ''
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-'*word.length
    @check_win_or_lose = :play
  end
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-'*word.length
    @check_win_or_lose = :play
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
end
