require_relative '../config/environment'

puts Analyzer.run("./data/artist_list.txt", 50).inspect
