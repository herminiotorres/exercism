class Raindrops
  def self.convert(value)
    return value.to_s unless pling?(value) || plang?(value) || plong?(value)
    "#{pling(value)}#{plang(value)}#{plong(value)}"
  end

  def self.pling(value)
    'Pling' if pling?(value)
  end

  def self.pling?(value)
    value % 3 == 0
  end

  def self.plang(value)
    'Plang' if plang?(value)
  end

  def self.plang?(value)
    value % 5 == 0
  end

  def self.plong(value)
    'Plong' if plong?(value)
  end

  def self.plong?(value)
    value % 7 == 0
  end
end
