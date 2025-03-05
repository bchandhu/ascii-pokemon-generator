require 'sinatra'
require 'sinatra/reloader' if development?
require 'http'
require 'mini_magick'

set :port, ENV['PORT'] || 3000

# ASCII conversion function
def convert_to_ascii(image_url)
  begin
    image = MiniMagick::Image.open(image_url)
    image.resize "50x50"   # Resize for ASCII conversion
    image.colorspace "Gray"  # Convert to grayscale

    ascii_chars = ["@", "#", "S", "%", "?", "*", "+", ";", ":", ",", "."]
    ascii_art = ""

    image.get_pixels.each do |row|
      row.each do |pixel|
        brightness = pixel.sum / 3  # Average RGB
        ascii_art += ascii_chars[brightness * ascii_chars.size / 256]
      end
      ascii_art += "\n"
    end

    ascii_art
  rescue => e
    "ASCII conversion failed: #{e.message}"
  end
end

get('/') do
  random_pokemon_num = rand(1..1025).to_i
  pokemon_api = HTTP.get("https://pokeapi.co/api/v2/pokemon/#{random_pokemon_num}")
  rand_pokemon_parsed = pokemon_api.parse

  @pokedex_num = random_pokemon_num
  @name = rand_pokemon_parsed['name']
  @sprite = rand_pokemon_parsed['sprites']['other']['official-artwork']['front_default']

  # Validate sprite URL before conversion
  if @sprite.nil? || @sprite.empty?
    @ascii_sprite = "No sprite available"
  else
    @ascii_sprite = convert_to_ascii(@sprite)
  end

  erb :index
end
