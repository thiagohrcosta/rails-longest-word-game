require 'open-uri'

class GamesController < ApplicationController
  def new
    # my_letters_array = [
    #   'a', 'b', 'c', 'd', 'e', 'f', 'g', 'i', 'j', 'l', 'm', 'n', 'o', 'p', 'q',
    #   's', 't', 'u', 'v', 'x', 'y', 'w', 'z'
    # ]

    # total_words = 0

    # @letters = []

    # my_letters_array.each do |element|
    #   while total_words < 10
    #     element = my_letters_array[rand(my_letters_array.length)]
    #     @letters << element
    #     total_words += 1
    #   end
    # end
    # @letters

    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score

    @answer = params[:word]
    @english = english_word?(@answer)
    # raise
    # user_word
    @valid_word = valid_word?(@answer)
  end

  private

  def valid_word?(word)
    attepted_word = word.upcase.chars

    @possible_letters = params[:letters]

    attepted_word.each do |letter|
    #binding.pry
      if @possible_letters.include?(letter)
        @possible_letters.delete(letter)
      else
        return false
      end
    end

    return true

  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
