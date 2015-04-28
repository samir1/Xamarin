require 'wolfram'
require 'uri'
require 'json'
require 'wikipedia'


actor = "Miles Teller"
page = Wikipedia.find(actor).content
# index = /([0-9][0-9][0-9][0-9][|][0-9]{1,2}[|][0-9]{1,2})/ =~ page
# page = page[index..index+9]
puts page

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
	actor_query = movie + ' movie cast'
	actor_result = Wolfram.fetch(actor_query)
	actor_hash = Wolfram::HashPresenter.new(actor_result).to_hash
	actor_hash = actor_hash[:pods]["Result"][0].split("\n")
	actor_hash.shift
	actor_hash.each do |actor_line|
		actor = actor_line.split(" | ")[0]
		puts "#{actor}"
		puts "#{actor} #{age_of actor}"
	end
	puts
	puts
end

