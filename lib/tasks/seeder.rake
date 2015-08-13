require 'open-uri'
require "net/http"

namespace :seed do
	task upload: :environment do
		image = File.open('/home/alenteria/shit.jpg')
		total_time = 0.0
		(1..1000).each do |i|
			start_time = Time.now
			upload = Upload.create(upload: image)
			end_time = Time.now
			print '.'
			total_time += end_time - start_time			
		end
		puts "\n#{1000/total_time} uploads per second"
		puts "1000 total uploads in #{total_time} seconds"
	end
end