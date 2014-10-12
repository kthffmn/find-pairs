require_relative '../config/environment'

Analyzer.new("./data/artist_list.txt", 50)

this = CountMinSketch.new(64, 64)
this.insert("harold")
this.debug
this.insert("katie")
this.insert("harold")
this.debug
