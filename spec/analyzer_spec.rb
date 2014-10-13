describe "Analyzer" do
  
  let(:short_analyzer)  { Analyzer.new("spec/support/short.txt",  "spec/results/short_result.txt",  2, 10, 100000)}
  let(:medium_analyzer) { Analyzer.new("spec/support/medium.txt", "spec/results/medium_result.txt", 3, 10, 100000)}
  let(:long_analyzer)   { Analyzer.new("spec/support/long.txt",   "spec/results/short_result.txt",  4, 10, 100000)}

  it "is initiated with input path, output path, threshold, k, and m arguments" do
    [short_analyzer, medium_analyzer, long_analyzer].each do |analyzer|
      expect { analyzer }.to_not raise_error
    end
  end

end