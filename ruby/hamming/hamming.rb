class Hamming
  def self.compute(strands_first, strands_last)
    raise ArgumentError unless strands_first.size == strands_last.size
    count = 0
    zero = 0
    strands_size = (strands_first.size - 1)
    zero.upto(strands_size) do |i|
      count += 1 if strands_first[i] != strands_last[i]
    end
    return count
  end
end
