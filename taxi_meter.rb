require 'time'

class TaxiMeter
  attr_reader :start_time, :stop_time
  attr_accessor :miles_driven

  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
    @airport = airport
    @prorate_distance = 1.0/6.0
  end

  def start
    @start_time = Time.now

    if @airport then @amount_due += 1310 end

    if @start_time >= Time.parse('9 pm') || @start_time <= Time.parse('4 am') then @amount_due += 100 end

  end

  def stop
    @stop_time = Time.now
  end

  def amount_due
    if @miles_driven == 0
      @amount_due
    elsif @miles_driven <= @prorate_distance
      @amount_due += 250
    else
      @amount_due += 250
      @miles_driven -= @prorate_distance
      distance_charges(@miles_driven)
    end
  end


  def distance_charges(distance)
    distance <= @prorate_distance ? @amount_due += (240 * @prorate_distance).to_i : distance_charges(distance - @prorate_distance)
  end


end
