class Analyzer
  attr_reader :data, :threshold, :pair_counts

  def initialize(file_path, threshold, k=10, m=64)
    @threshold = threshold
    @pair_counts = CountMinSketch.new(k, m)
    @data = load_file(file_path)
  end

  def find_pairs
    results = Set.new
    data.each do |list|
      list.each_with_index do |band, i|
        j = i + 1
        while j < list.length
          pair = "#{band}, #{list[j]}"
          unless results.include?(pair)
            num = pair_counts.insert(pair)
            results << pair if num >= 50
          end
          j += 1
        end
      end
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
