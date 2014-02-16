class TaxiMeter

  WAIT_TIME_SURCHARGE_PER_MINUTE = 2900 / 60.0 # $29.00 per hour
  AIRPORT_SURCHARGE_IN_CENTS = 1310 # $13.10 when starting at airport

  attr_accessor :amount_due, :miles_driven, :wait_time, :airport
  attr_reader :stop_time, :start_time

  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
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
      (Time.now - @start_time) / 60
  end

  def time_amount_due
    (wait_time * WAIT_TIME_SURCHARGE_PER_MINUTE).round(-1)
  end

  def mileage_amount_due
    return 0 if @miles_driven.zero?
    210 + 40 * (@miles_driven * 6.0).round
  end

  def airport_surcharge
    return AIRPORT_SURCHARGE_IN_CENTS if (@amount_due < 1310 && @airport == true); 0
  end

  def after_hours_surcharge # $1 (in cents) extra fee if meter run after hours
    time = Time.now
    return 100.0 if time.hour > 20 || time.hour < 5; 0
  end

  def amount_due
    mileage_amount_due + time_amount_due + airport_surcharge + after_hours_surcharge
  end
end
