class Analyzer
  attr_reader :data, :threshold, :pair_counts

  def initialize(file_path, threshold, k=64, m=128)
    @threshold = threshold
    @pair_counts = CountMinSketch.new(k, m)
    @data = load_file(file_path)
  end

  def find_pairs
    results = Set.new
    data.each_with_index do |bands, index|
      puts "index: #{index}"
      bands.each_with_index do |left_band, i|
        bands[i + 1..-1].each do |right_band|
          pair = "#{left_band}, #{right_band}"
          unless results.include?(pair)
            num = pair_counts.insert(pair)
            results << pair if num >= 50
            puts "num: #{num}"
          end
        end
      end
      puts "results: #{results.length}"
      binding.pry
    end
    results
  end

  def load_file(file_path)
    lists = []
    File.foreach(file_path) do |list|
      lists << list.strip.split(",").sort
    end
    lists
  end

  def save(results)
    File.open("data/result.txt", 'w') do |file| 
      file.write(results.join("\n"))
    end
  end

end
