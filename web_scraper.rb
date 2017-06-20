require 'HTTParty'
require 'nokogiri'
require 'open-uri'


puts "What city are you interested in renting a 3 bedroom and 2 bathroom place in?"

#variable input
city = gets.downcase.delete(' ').chomp
bed = 3
bath = 2

#URL necessary for scraper

url = "https://#{city}.craigslist.org/search/swp?min_bedrooms=#{bed}&max_bedrooms=#{bed}&min_bathrooms=#{bath}&max_bathrooms=#{bath}&availabilityMode=0"

response = HTTParty.get url

#Parse with Nokogiri
page = Nokogiri::HTML(response)

######################################################################
#Display Section - This section of the script was built to find the desired HTML data to scrape by displaying it in the terminal
#display title output on the screen
#
# page.css('a.result-title').each do |line|
#   puts line.text
# end
#
# # show address output on the screen
# page.css('span.result-hood').each do |line|
#   puts line.text
# end
#
# #show rent price on the screen
# page.css('span.result-price').each do |line|
#   puts line.text
# end
#
# #URL to the original listing
# page.css('p.result-info').css('a').each do |line|
#   puts line['href']
# end

######################################################################
#Build Section - This portion of the script was built to create the arrays that would store each column of data for the CSV file
#Title array for csv
title = []
page.css('a.result-title').each do |line|
  title << line.text
end

#Address array for csv
address = []
page.css('span.result-hood').each do |line|
  address << line.text
end

#Rent array for csv
rent = []
page.css('span.result-price').each do |line|
  rent << line.text
end


#URL array for csv
url = []
page.css('p.result-info').css('a').each do |line|
  url << line['href']
  url.delete('#')
end

CSV.open('appointments.csv', 'w') do |csv|
  csv << ["Title", "URL", "Address", "Rent"]

  title.length.times do |i|
    csv << [title[i], url[i], address[i], rent[i]]
  end
end

p title
p address
p rent
p url
