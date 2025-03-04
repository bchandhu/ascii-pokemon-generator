require 'sinatra'
require 'sinatra/reloader'
require 'http'
require 'asciiart'

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
  puts @name
  puts @ascii_sprite

  erb(:index)
end
