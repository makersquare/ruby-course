class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :wait_time, :airport
  attr_reader :stop_time, :start_time

  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
    @wait_time = 0
    @airport = airport
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def wait_time
    # return 0 if @stop_time.nil? || @start_time.nil?

    (Time.now - @start_time) / 60
  end

  def time_amount_due
    (wait_time * (2900 / 60.0)).round(-1)
  end

  def mileage_amount_due
    # return 250 if @miles_driven.zero?
    return 0 if @miles_driven.zero?
    210 + 40 * (@miles_driven * 6.0)
  end

  def airport_surcharge
    # return 250 if @miles_driven.zero? && airport == false
    return 1310 if (@amount_due < 1310 && @airport == true); 0
  end

  def after_hours_surcharge
    time = Time.now
    return 100.0 if time.hour > 20 || time.hour < 5; 0
  end

  def amount_due
    mileage_amount_due + time_amount_due + airport_surcharge + after_hours_surcharge
  end
end
