#README

- Challenge -

- Write a web scraper that will generate a csv of all the 3 bedroom, 2 bathroom homes for rent in a given city on Craigslist.
- The CSV should have the following columns: title, address (if available), monthly rent (if available), URL to original listing.

The App required me to use Nokogiri, HTTParty, Open-URI.

##Display

After adding my dependencies I decided to start by displaying what my code was doing first in the terminal before building the actual data structures with the parsed data. I called it "The Display Section"

##Build

The next portion of the script is "The Build Section" and it is where I built the arrays that would be loaded into the CSV file.

##Appointments - CSV
The headers for this file are:
 - Title
 - URL
 - Address
 - Rent
