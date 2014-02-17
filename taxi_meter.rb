require 'time'

class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time, :airport
  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
    @start_time = 0
    @stop_time = nil
    @airport = airport
  end

  def calculate_rate
    first_sixth
    airport_rate
    late_rate
    rate_per_minute
    rate_per_sixth

    @amount_due /= 100
    return @amount_due.round(2)
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def first_sixth
    @miles_driven += (1.0/6.0)
    @amount_due += 250
  end

  def add_distance(x)
    @miles_driven += x
  end

  def rate_per_sixth
    @amount_due += (40 * (miles_driven * 6))
  end

  def rate_per_minute
    total_time = (@stop_time - @start_time) / 60
    @amount_due += (total_time * 48.333333)
  end

  def airport_rate
    if @airport
      @amount_due += 1310
    end
  end

  def late_rate
    if @start_time > Time.parse("9 pm") || @start_time < Time.parse("4 am")
      @amount_due += 100
    end
  end

end
