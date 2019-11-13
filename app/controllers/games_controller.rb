class GamesController < ApplicationController

  def grid
    @letters = ''
    @letters << random_letter_method
    @letters << random_vowel_method.join
    @letters = @letters.chars.sort_by { rand }
    # ('a'..'z').to_a.sample(10)
    # grid = @letters
  end

  def results
    @aggregate_score = 0
    given_answer = params[:scrabble_word]
    grid = JSON.parse(params[:letters])
    answer_array = given_answer.chars
    answer_array.each do |answer_letter|
      if letter_included(grid, answer_letter) == true
        deduct_letter(grid, answer_letter)
        @aggregate_score += 1
      else
        @aggregate_score = 0
      end
    end
  end


  private
  def random_letter_method
    size = random_number
    charset = %w{b c d f g h j k l m n p q r s t v w x y z}
    random_letters = (0...size).map { charset.to_a[rand(charset.size)] }.join
  end

  def random_vowel_method
    random_vowels = ""
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
