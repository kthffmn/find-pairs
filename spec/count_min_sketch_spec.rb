describe "CountMinSketch" do
  
  let(:count_min_sketch) { CountMinSketch.new(30, 128) } 
  let(:band) { "Sylvan Esso" }
  let(:singer) { "Valerie June" }

  describe "::MAX_FIXNUM" do
    it "knows what MAX_FIXNUM is" do
      expect { CountMinSketch::MAX_FIXNUM }.to_not raise_error
    end

    it "is the maximum Fixnum on the machine" do
      expect(CountMinSketch::MAX_FIXNUM.class).to eq(Fixnum)
      expect((CountMinSketch::MAX_FIXNUM + 1).class).to eq(Bignum)
    end
  end

  describe "#initialize" do
    it "does not raise an error initialized with an m of 128" do
      expect { count_min_sketch }.to_not raise_error
    end

    it "raises an error initialized with an m that is not 128" do
      expect { CountMinSketch.new(10, 32) }.to raise_error
    end
  end

  describe "#insert" do
    it "returns a count of one when a string is added once" do
      expect(count_min_sketch.insert(singer)).to eq(1)
    end

    it "returns a count of two when a string is added once, then a second time" do
      count_min_sketch.insert(band)
      expect(count_min_sketch.insert(band)).to eq(2)
    end

    it "returns a count of two when a string is added with optional times argument of 2" do
      expect(count_min_sketch.insert(singer, 2)).to eq(2)
    end

    it "returns a count of ten when a string is added with optional times argument of 10" do
      expect(count_min_sketch.insert(band, 10)).to eq(10)
    end
  end

  describe "#get_count" do
    it "remembers when a string is added once" do
      count_min_sketch.insert(band)
      expect(count_min_sketch.get_count(band)).to eq(1)
    end

    it "remembers when the same string is added twice" do
      2.times { count_min_sketch.insert(singer) }
      expect(count_min_sketch.get_count(singer)).to eq(2)
    end

    it "returns a count of zero for strings that have not been added" do
      expect(count_min_sketch.get_count("Rhye")).to eq(0)
    end

    it "returns a zero count for a string that has not been added 
      regardless of other added strings" do
      2.times do 
        count_min_sketch.insert(singer)
        count_min_sketch.insert(band)
      end
      expect(count_min_sketch.get_count("Rhye")).to eq(0)
    end

    it "returns the correct count of one regardless of other added strings" do
      count_min_sketch.insert(band)
      expect(count_min_sketch.get_count(band)).to eq(1)
      2.times { count_min_sketch.insert(singer) }
      expect(count_min_sketch.get_count(band)).to eq(1)
    end

    it "returns the correct count of two regardless of other added strings" do
      2.times { count_min_sketch.insert(singer) }
      expect(count_min_sketch.get_count(singer)).to eq(2)
      3.times { count_min_sketch.insert(band) }
      expect(count_min_sketch.get_count(singer)).to eq(2)
    end
  end

end