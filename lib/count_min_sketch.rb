class Matrix
  public :[]=
end

class CountMinSketch

  MAX_FIXNUM = 2 ** (0.size*8 - 3)

  attr_reader :k, :m, :seeds

  def initialize(k, m)
    raise 'Only 64 bit is currently supported' if m != 64
    @k = k
    @m = m
    @data = Matrix.zero(k, m)
    @seeds = Array.new(k) { rand(MAX_FIXNUM) }
  end

  def insert(x)
    do_count(x, true)
  end

  def get_count(x)
    do_count(x, false)
  end

  def debug
    binding.pry
  end

  private

  def do_count(x, increment)
    min_count = Float::INFINITY
    hashes_of_x = seeds.map { |s| CityHash.hash64(x, s) }
    hashes_of_x.each_with_index do |hash, i|
      m.times do |j|
        if hash & (2 ** j) != 0
          if increment
            count = @data[i, j] += 1
          else
            count = @data[i, j]
          end
          min_count = count if count < min_count
        end
      end
    end
    min_count
  end

end

