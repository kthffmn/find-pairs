require_relative '../config/environment'

start = Time.now
Analyzer.run("data/artist_list.txt", "data/result.txt", 50)
finish = Time.now

puts "Completed! Process took #{(finish - start).to_i} seconds"
