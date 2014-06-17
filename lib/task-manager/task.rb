class TM::Task
  attr_reader :desc, :key, :done, :date

  def initialize(desc, key)
    @desc = desc
    @key = key
    @done = false
    @date = Time.now
  end
  def complete
    @done = true
  end
end
