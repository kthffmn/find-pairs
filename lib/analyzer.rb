class Analyzer
  attr_reader :band_lists, :appearance_num
  attr_accessor :results

  def initialize(file_path, appearance_num)
    @appearance_num = appearance_num
    @band_lists = []
    File.foreach(file_path) do |list|
      band_lists << list.strip.split(",")
    end
    @results = []
  end

  def save
    final_results = results.join("\n")
    File.open("data/result.txt", 'w') do |file| 
      file.write(final_results)
    end
  end
end
