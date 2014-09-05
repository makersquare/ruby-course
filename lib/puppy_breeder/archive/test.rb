class MyHash
  def initialize
    @pairs = Array.new(4)
  end

  def []=(key, value)
    index = find_index(key)
    @pairs[index] = value
  end

  def [](key)
    index = find_index(key)
    @pairs[index]
  end
end


