class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :wait_time
  attr_reader :stop_time

  def initialize
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
    @wait_time = 0
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def wait_time
    return 0 if @stop_time.nil? || @start_time.nil?

    (@stop_time - @start_time) / 60
  end

  def time_amount_due
    wait_time * (2900 / 60.0)
  end

  def mileage_amount_due
    return 250 if @miles_driven.zero?

    (210 + 40 * (@miles_driven * 6.0))
  end

  def amount_due
    mileage_amount_due + time_amount_due
  end
end
