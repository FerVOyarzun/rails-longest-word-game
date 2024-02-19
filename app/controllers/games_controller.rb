require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split

    if valid_word?(@word, @letters)
      @answervalid = "exist"
    else
      @answervalid = "not exist"
    end

    if exist?(@word) == true
      @answer = "Felicidades, #{@word} es una palabra en ingles"
    else
      @answer = "#{@word} NO es una palabra en ingles"
    end

  end

  def exist?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    html_file = JSON.parse(response.read)
    html_file['found']
  end

  def valid_word?(word, letters)
    word.chars.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end
end
