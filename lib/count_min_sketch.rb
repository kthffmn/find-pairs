class Matrix
  public :[]=
end

class CountMinSketch

  MAX_FIXNUM = 2**(0.size*8 - 2) - 1

  attr_reader :k, :m, :data

  def initialize(k, m)
    @k = k
    @m = m
    @data = Matrix.zero(k, m)
    @seeds = Array.new(k) { rand(MAX_FIXNUM + 1) }
  end

  def get_count(x)
    insert(x, 0)
  end

  def insert(x, n=1)
    min_count = Float::INFINITY
    hashes_of_x = @seeds.map { |s| CityHash.hash64(x, s) }
    hashes_of_x.each_with_index do |hash, i|
      j = hash % m
      count = @data[i, j] += n
      min_count = count if count < min_count
    end
    min_count
  end

end
