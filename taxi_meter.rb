require 'time'

class TaxiMeter
  attr_accessor :start_time, :stop_time, :miles_driven, :amount_due

  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
    @airport = airport
    @prorate = 1.0/6.0
  end

  def start
    @start_time = Time.now
    if @start_time >= Time.parse('9 pm') || @start_time <= Time.parse('4 am') then @amount_due += 100 end
  end

  def stop
    @stop_time = Time.now
  end

  def amount_due
    total = @amount_due + distance_charge + time_charge
    total < 1310 && @airport ? 1310 : total.to_i

  end

  def distance_charge
    distance = @miles_driven * 6
    charge = 0

    while distance > 0.00
      # Charge $2.50 for first 1/6 mile and $0.40 for every 1/6 mile after that
      distance <= 1 ? charge += 250 : charge += 40
      distance -= 1
    end

    charge
  end

  def time_charge
    @stop_time ? time = @stop_time : time = Time.now
    ((time - start_time) / 60.0).ceil * (2900/60.0)
  end


end
