require_relative '../config/environment'

puts Analyzer.run("data/artist_list.txt", "data/result.txt", 50).inspect
