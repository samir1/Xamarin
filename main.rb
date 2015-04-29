require 'wolfram'
require 'uri'
require 'open-uri'
require 'json'
require 'wikipedia'


# actor = "Miles Teller"
# page = Wikipedia.find(actor).content
# # index = /([0-9][0-9][0-9][0-9][|][0-9]{1,2}[|][0-9]{1,2})/ =~ page
# # page = page[index..index+9]
# puts page

def age_of actor
	# page = Wikipedia.find(actor).content
	# start_index = page.index('{{Birth date and age|')
	# if start_index.nil?
	# 	start_index = page.index('{{birth date and age|')
	# end
	# page = page[start_index..-1]
	# end_index = page.index('}}')-1
	# page = page[end_index-9..end_index]
	page = Wikipedia.find(actor).content
	index = /([0-9][0-9][0-9][0-9][|][0-9]{1,2}[|][0-9]{1,2})/ =~ page
	page = page[index..index+9]
	page
end

Wolfram.appid = 'HU838J-6VWELQ7KA8'

query = 'movies in theaters'
result = Wolfram.fetch(query)
hash = Wolfram::HashPresenter.new(result).to_hash
hash = hash[:pods]["Result"][0].split("\n")
hash.each do |line|
	movie = line.split(" | ")[1]
	puts movie
	movie_imdb  = open(URI.escape("http://www.omdbapi.com/?t=#{movie}&y=&plot=short&r=json")) {|f| f.read }
	parsed = JSON.parse(movie_imdb)
	actors = parsed["Actors"].split(", ")
	actors.each do |actor|
		puts "#{actor} #{age_of actor}"
	end
	puts
	puts
end

