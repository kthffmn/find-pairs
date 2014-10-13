require_relative '../config/environment'

start_time = Time.now

puts Analyzer.run("data/artist_list.txt", "data/result.txt", 50).inspect

end_time = Time.now

puts "Took #{(end_time - start_time).to_i} second(s)"
