require 'wolfram'
require 'uri'
require 'open-uri'
require 'json'
require 'wikipedia'

def age_of actor
	page = Wikipedia.find(actor).content
	page = page.match(/([0-9][0-9][0-9][0-9][|][0-9]{1,2}[|][0-9]{1,2})/)[1]
	page
end

Wolfram.appid = 'KEY'

query = 'movies in theaters'
result = Wolfram.fetch(query)
hash = Wolfram::HashPresenter.new(result).to_hash
hash = hash[:pods]["Result"][0].split("\n")
hash.each do |line|
	movie = line.split(" | ")[1]
	puts movie
	movie_imdb  = open(URI.escape("http://www.omdbapi.com/?t=#{movie}&y=#{Time.new.year}&plot=short&r=json")) {|f| f.read }
	parsed = JSON.parse(movie_imdb)
	actors = parsed["Actors"].split(", ")
	actors.each do |actor|
		puts "#{actor} #{age_of actor}"
	end
	puts
	puts
end

