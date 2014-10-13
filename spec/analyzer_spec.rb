describe "Analyzer" do
  
  let(:analyzer)  { Analyzer.new("spec/support/short.txt",  "spec/results/short_result.txt",  2, 10, 100000) }
  let(:run)       { Analyzer.run("spec/support/short.txt",  "spec/results/short_result.txt",  2) }
  let(:results)   { {"short" => "Chvrches,Valerie June", "medium" => "Miranda Lambert,The Flaming Lips", "long" => "Chvrches,St. Vincent"} }
  
  describe "#initialize" do
    it "is initiated with input path, output path, threshold, k, and m arguments" do
      expect { analyzer }.to_not raise_error
    end
    it "initiates a new instance of the CountMinSketch class called 'pair_counts'" do
      expect(analyzer.pair_counts.class).to eq(CountMinSketch)
    end
    it "loads the input file as an array and sets it equal to 'data'" do
      expect(analyzer.data.class).to eq(Array)
      expect(analyzer.data.length).to eq(10)
      analyzer.data.each { |bands| expect(bands.length).to eq(3) }
    end
    it "initiates two new sets, 'results' and 'verified_results'" do
      [analyzer.results.class, analyzer.verified_results.class].each do |class_name|
        expect(class_name).to eq(Set)
      end
    end
  end

  describe "#run" do
    it "is called with input path, output path, and threshold" do
      expect { run }.to_not raise_error
    end

    it "accepts optional arguments of k and m" do
      expect { Analyzer.run("spec/support/long.txt", "spec/results/long_result.txt", 4, 15, 10000) }.to_not raise_error
    end

    it "saves the pair that is repeated at least 'threshold' times in the input to the output" do
      threshold = 2
      lengths = ["short", "medium", "long"]
      lengths.each do |length|
        input, output = get_paths(length)
        Analyzer.run(input, output, threshold)
        result = File.read(output)
        expect(result).to match(/#{results[length]}/)
        threshold += 1
      end
    end
  end

end