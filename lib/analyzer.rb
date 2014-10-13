class Analyzer
  attr_reader :data, :threshold, :pair_counts, :results, :verified_results

  def initialize(file_path, threshold, k, m)
    @threshold = threshold
    @pair_counts = CountMinSketch.new(k, m)
    @data = load_file(file_path)
    @results = Set.new
    @verified_results = Set.new
  end

  def self.run(file_path, threshold, k=10, m=100000)
    self.new(file_path, threshold, k, m)
    self.find_pairs
    self.verified_results
    self.save
  end

  def verify_results
    find_pairs(true)
  end

  def find_pairs(verify=false)
    verified_pair_counts = Hash.new(0) if verify
    data.each_with_index do |bands, index|
      bands.each_with_index do |left_band, i|
        bands[i + 1..-1].each do |right_band|
          pair = "#{left_band}, #{right_band}"
          if verify
            update_verified_results(verified_pair_counts, pair)
          else
            update_results(pair)
          end
        end
      end
    end
  end

  def update_results(pair)
    unless results.include?(pair)
      num = pair_counts.insert(pair)
      results << pair if num >= 50
    end
  end

  def update_verified_results(verified_pair_counts, pair)
    if results.include?(pair) && !verified_results.include?(pair)
      num = verified_pair_counts[pair] += 1
      verified_results << pair if num >= 50
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
    File.open("data/result.txt", 'w') do |file| 
      file.write(verified_results.to_a.join("\n"))
    end
  end

end
