require 'nokogiri'
require 'open-uri'
require 'csv'




bed = 3
bath = 2

#For the sake of this exercise this city variable is hard coded but could be 'gets.chomp' and puts a string requesting input from the user to interpolate the city into the craigslist url.
city = "miami"

site = "https://#{city}.craigslist.org/search/swp?min_bedrooms=#{bed}&max_bedrooms=#{bed}&min_bathrooms=#{bath}&max_bathrooms=#{bath}&availabilityMode=0"

doc = Nokogiri::HTML(open(site))

entries = doc.css('.result-row')

# p entries.length

##############Display Section###################

#Title

# p entries[0].css('p.result-info>a').text
#
# #URL
#
# p entries[0].css('p.result-info>a')[0]['href']
#
# #Rent
#
# p entries[0].css('.result-meta').css('.result-price').text
#
# #Address
#
# p entries[0].css('span.result-hood').text

# entries.each do |entry|
#  puts entry.css('p.result-info>a').text
#  puts entry.css('p.result-info>a')[0]['href']
#  puts entry.css('.result-meta').css('.result-price').text
#  puts entry.css('span.result-hood').text
# end

##############Build Section###################

class Entry
  def initialize(title, url, rent, address)
    @title = title
    @url = url
    @rent = rent
    @address = address
  end
  attr_reader :title, :url, :rent, :address
end



entries_array = []

entries.each do |entry|
 title = entry.css('p.result-info>a').text
 url = entry.css('p.result-info>a')[0]['href']
 rent = entry.css('.result-meta').css('.result-price').text
 address = entry.css('span.result-hood').text
 entries_array << Entry.new(title, url, rent, address)
end

CSV.open('appointments_revised.csv', 'w') do |csv|
  csv << ["Title", "URL", "Rent", "Address"]

  entries_array.length.times do |i|
    csv << [entries_array[i].title, entries_array[i].url, entries_array[i].rent, entries_array[i].address]
  end
end
