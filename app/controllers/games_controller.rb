require "open-uri"

class GamesController < ApplicationController


  def new
    @letters = ('a'..'z').to_a.sample(10)
    # @letters is randam 10 alphabet letters
  end

  def score
    @input = params[:new]
    @letters = params[:letters]
    @array = @letters.chars.select{|char| char.match(/[a-z]/) }
    # @array.(@input)
    valid_answer = @input.chars.all? { |letter| @array.include?(letter) }
    url = "https://wagon-dictionary.herokuapp.com/#{@input}"
    json = URI.open(url).read
    hash = JSON.parse(json)

    @result = "Sorry but #{@input} can't be built out of #{@array.join(",")}"
    @result = "Sorry but #{@input} does'n seem to be a valid English word" if valid_answer
    @result = "Congratulations! #{@input} is a valid English word" if hash["found"] && valid_answer

  end
end
