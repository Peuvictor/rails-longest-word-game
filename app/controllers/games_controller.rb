require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # lógica para gerar a grade de letras
    @letters = ['a', 'b', 'c', 'd', 'e']

  end

 def score
  @word = params[:word]
  @letters = params[:letters].split
  @valid_word = valid_word?(@word)
  @included = included?(@word, @letters)
  @score = calculate_score(@word) if @valid_word && @included

  session[:total_score] ||= 0
  session[:total_score] += @score if @score
end

  private

  def valid_word?(word)
    begin
      url = "https://wagon-dictionary.herokuapp.com/#{word}"
      response = URI.open(url).read
      json = JSON.parse(response)
      return json['found']
    rescue Errno::ENOENT => e
      Rails.logger.error("Erro ao acessar a URL: #{e.message}")
      return false
    end
  end
end
