require 'sinatra'
require 'sinatra/reloader'
require 'http'

# AsciiArt and RMagick don't work on Render or Codespaces since I can't figure out how to install the needed dependancies. :(
require 'mini_magick'
require 'rmagick'
require 'asciiart'

set :port, ENV['PORT'] || 4567

before do
  @random_pokemon_num = rand(1..1025).to_i
  pokemon_api = HTTP.get("https://pokeapi.co/api/v2/pokemon/#{@random_pokemon_num}")
  @rand_pokemon_parsed = pokemon_api.parse
end

get('/') do
  @pokedex_num = @random_pokemon_num
  @name = @rand_pokemon_parsed['name']
  @sprite = @rand_pokemon_parsed['sprites']['other']['official-artwork']['front_default']
  @ascii_sprite = AsciiArt.new(@sprite.to_s).to_ascii_art(width: 50, invert_chars: true)

  erb(:index)
end
