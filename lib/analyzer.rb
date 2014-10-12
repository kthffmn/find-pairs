class Analyzer
  attr_reader :band_lists, :appearance_num, :count_min_sketch
  attr_accessor :results

  def initialize(file_path, appearance_num, k = 64, m = 64)
    @appearance_num = appearance_num
    @count_min_sketch = CountMinSketch.new(k, m)
    @band_lists = load_file(file_path)
    @results = []
  end

  def find_pairs
    # stuff
  end

  def load_file(file_path)
    lists = []
    File.foreach(file_path) do |list|
      lists << list.strip.split(",")
    end
  end

  def save
    final_results = results.join("\n")
    File.open("data/result.txt", 'w') do |file| 
      file.write(final_results)
    end
  end

end
