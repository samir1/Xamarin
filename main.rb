require 'open-uri'
require 'json'
require 'wolfram'

Wolfram.appid = 'KEY'

query = 'movies in theaters'
result = Wolfram.fetch(query)
hash = Wolfram::HashPresenter.new(result).to_hash
hash = hash[:pods]["Result"][0].split("\n")
hash.each do |line|
	movie = line.split(" | ")[1]
	puts movie
	actor_query = movie + ' movie cast'
	actor_result = Wolfram.fetch(actor_query)
	actor_hash = Wolfram::HashPresenter.new(actor_result).to_hash
	actor_hash = actor_hash[:pods]["Result"][0].split("\n")
	actor_hash.shift
	actors = Array.new
	actor_hash.each do |actor|
	  actors.push actor.split(" | ")[0]
	end
	puts actors
	puts
	puts
end