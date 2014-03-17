require 'time'

class TaxiMeter
  attr_accessor :start_time, :stop_time, :miles_driven
  attr_writer :amount_due

  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
    @airport = airport
    @night_start = '9 pm'
    @night_end = '4 am'
    @night_surcharge = 100
  end

  def start
    @start_time = Time.now
    if @start_time >= Time.parse(@night_start) || @start_time <= Time.parse(@night_end)
      @amount_due += @night_surcharge
    end
  end

  def stop
    if @start_time then @stop_time = Time.now end
  end

  def amount_due
    unless @start_time then return @amount_due end
    total = @amount_due + distance_charge + time_charge
    total < 1310 && @airport ? 1310 : total.round

  end

  def distance_charge
    distance = @miles_driven * 6
    charge = 0

    if distance == 0 then charge += 250 end

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
