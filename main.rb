require 'fandango'
require 'json'
require 'open-uri'
require 'uri'
require 'wikipedia'
require 'wolfram'

# returns an array that contains movies in theaters using the wolfram gem
def movies_in_theaters
	query = 'movies in theaters'
	result = Wolfram.fetch(query)
	movies = Wolfram::HashPresenter.new(result).to_hash
	movies = movies[:pods]["Result"][0].split("\n")
end

#  returns an array containing actors in a movie using omdbapi.com
def actors_in movie
	movie_imdb  = open(URI.escape("http://www.omdbapi.com/?t=#{movie}&y=#{Time.new.year}&plot=short&r=json")) {|f| f.read }
	parsed = JSON.parse(movie_imdb)
	actors = parsed["Actors"].split(", ")
end

# returns the age of an actor using a wikipedia gem
def age_of actor
	page = Wikipedia.find(actor).content
	birthday = page.match(/([0-9][0-9][0-9][0-9][|][0-9]{1,2}[|][0-9]{1,2})/)[1]
	birthday = Date.parse((birthday).gsub("|","-"))
	now = Time.now.to_date
	now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
end

Wolfram.appid = 'KEY' # Wolfram app id HU838J-6VWELQ7KA8

movies = movies_in_theaters
movies.each do |line| # loops through movies in movie theaters
	movie = line.split(" | ")[1]
	puts movie # prints movie title
	actors = actors_in movie
	average_age = 0 # stores the average age of actors in a movie
	actors.each do |actor| # loops through actors in a movie, prints the actor and actor's age
		age = age_of actor
		average_age += age
		puts "#{actor} (age #{age})"
	end
	average_age = (average_age / actors.size.to_f).round # calculate average age
	puts "Average age: #{average_age}"
	puts
	puts
end

