require 'open-uri'
require 'json'

puts Time.new.year

web_contents  = open('http://www.omdbapi.com/?t=Insurgent&y=&plot=short&r=json') {|f| f.read }
parsed = JSON.parse(web_contents)
actors = parsed["Actors"].split(", ")
puts actors