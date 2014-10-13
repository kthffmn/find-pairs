describe "Analyzer" do
  
  let(:short_analyzer)  { Analyzer.new("spec/support/short.txt",  "spec/results/short_result.txt",  2, 10, 100000)}
  let(:medium_analyzer) { Analyzer.new("spec/support/medium.txt", "spec/results/medium_result.txt", 3, 10, 100000)}
  let(:long_analyzer)   { Analyzer.new("spec/support/long.txt",   "spec/results/long_result.txt",  4, 10, 100000)}

  describe "#initialize" do
    it "is initiated with input path, output path, threshold, k, and m arguments" do
      [short_analyzer, medium_analyzer, long_analyzer].each do |analyzer|
        expect { analyzer }.to_not raise_error
      end
    end
    it "initiates a new instance of the CountMinSketch class called 'pair_counts'" do
      expect(short_analyzer.pair_counts.class).to eq(CountMinSketch)
    end
    it "loads the input file as an array and sets it equal to 'data'" do
      expect(short_analyzer.data.class).to eq(Array)
      expect(short_analyzer.data.length).to eq(10)
      short_analyzer.data.each { |bands| expect(bands.length).to eq(3) }
    end
    it "initiates two new sets, 'results' and 'verified_results'" do
      [short_analyzer.results.class, short_analyzer.verified_results.class].each do |class_name|
        expect(class_name).to eq(Set)
      end
    end
  end

  describe "#run" do
    it "is called with input path, output path, and threshold" do
      expect {  Analyzer.run("spec/support/long.txt", "spec/results/long_result.txt", 4) }.to_not raise_error
    end
    it "accepts optional arguments of k and m" do
      expect {  Analyzer.run("spec/support/long.txt", "spec/results/long_result.txt", 4, 15, 10000) }.to_not raise_error
    end
  end

end