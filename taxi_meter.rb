class TaxiMeter

  attr_reader :start_time, :stop_time
  attr_accessor :amount_due, :miles_driven

  def initialize
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
  end

  def one_sixth
    1.0 / 6.0
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end
end

