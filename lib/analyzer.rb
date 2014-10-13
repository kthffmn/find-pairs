class Analyzer
  attr_reader :data, :threshold, :pair_counts, :results, :verified_results, :output_path
  attr_accessor :pair
  
  def initialize(input_path, output_path, threshold, k, m)
    @threshold = threshold
    @output_path = output_path
    @data = load_file(input_path)
    @pair_counts = CountMinSketch.new(k, m)
    @results = Set.new
    @verified_results = Set.new
  end

  def self.run(input_path, output_path, threshold, k=10, m=100000)
    analyzer = self.new(input_path, output_path, threshold, k, m)
    analyzer.find_pairs
    analyzer.verify_results
    analyzer.save
  end

  def verify_results
    find_pairs(true)
  end

  def find_pairs(verify=false)
    verified_pair_counts = Hash.new(0) if verify
    data.each_with_index do |bands, index|
      bands.each_with_index do |left_band, i|
        bands[i + 1..-1].each do |right_band|
          self.pair = "#{left_band},#{right_band}"
          if verify
            update_verified_results(verified_pair_counts)
          else
            update_results
          end
        end
      end
    end
  end

  def update_results
    unless results.include?(pair)
      num = pair_counts.insert(pair)
      results << pair if num >= threshold
    end
  end

  def update_verified_results(verified_pair_counts)
    if results.include?(pair) && !verified_results.include?(pair)
      num = verified_pair_counts[pair] += 1
      verified_results << pair if num >= threshold
    end
  end

  def load_file(file_path)
    lists = []
    File.foreach(file_path) do |list|
      lists << list.strip.split(",").sort
    end
    lists
  end

  def save
    File.open(output_path, 'w') do |file| 
      file.write(verified_results.to_a.join("\n"))
    end
  end
end
