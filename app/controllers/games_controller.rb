class GamesController < ApplicationController

  def grid
    @letters = ''
    # empty string populated using method below
    @letters << random_letter_method
    @letters << random_vowel_method.join
    # mixes up the letters so vowels are not all at the end
    @letters = @letters.chars.sort_by { rand }
  end

  def results
    @aggregate_score = 0
    given_answer = params[:scrabble_word]
    grid = JSON.parse(params[:letters])
    answer_array = given_answer.chars
    answer_array.each do |answer_letter|
      # THIS STILL WON'T GET A VALID ARRAY FOR @LETTERS.  NIL
      if letter_included(@letters, answer_letter) == true
        @letters = deduct_letter(@letters, answer_letter)
        @aggregate_score += 1
      else
        @aggregate_score = 0
      end
    end
  end


  private
  def random_letter_method
    size = random_number
    # creates an array of the consonants
    charset = %w{b c d f g h j k l m n p q r s t v w x y z}
    # maps over specified size of letters and joins together to form a string.  why is the _to_a thing there?
    random_letters = (0...size).map { charset.to_a[rand(charset.size)] }.join
  end

  def random_vowel_method
    random_vowels = ''
    size = random_vowel_number
    charset = %w{a e i o u}
    random_vowels = (0...size).map { charset.to_a[rand(charset.size)] }.join
    random_vowels.chars.sort_by { rand }
  end

  def random_number
    (5..10).to_a.sample
  end

  def random_vowel_number
    (3..10).to_a.sample
  end

  def letter_included(array, letter)
    # ARRAY IS STILL NIL...
    # LETTER IS OKAY
    if array.include?(letter)
      true
    else
      false
    end
  end

  def deduct_letter(array, letter)
    i = array.index(letter)
    array.delete_at i
    array
  end
end
