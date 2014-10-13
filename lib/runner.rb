require_relative '../config/environment'

a = Analyzer.new("./data/artist_list.txt", 50)
puts a.find_pairs.inspect
