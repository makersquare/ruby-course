class TaxiMeter
  attr_accessor :amount_due, :miles_driven
  attr_reader :airport, :elapsed_time, :start_time, :stop_time

  def initialize(airport: false)
    @airport = airport
    @amount_due = 0
    @miles_driven = 0
    @price_per_unit_driven = 240
    @price_per_minute = (2900 / 60.0)

  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def amount_due
    if @start_time.hour > 21 || @start_time.hour < 4
      check_for_surcharges + 100
    else
      check_for_surcharges
    end
  end

  def check_for_surcharges
    @miles_driven = (@miles_driven * 6.0).ceil
    (@miles_driven = @miles_driven * one_sixth).round

    if @miles_driven == 0 && !@airport
      amount = 0
    elsif @miles_driven < 1.0 / 6 && !@airport
      amount = 250
    elsif @miles_driven <= 4.7 && @airport
      amount = 1310
    elsif @airport == true
      amount = ((@miles_driven - one_sixth) * 240 + 250).round
    else
      amount = ((@miles_driven - one_sixth) * 240 + 250).round
    end

    if @stop_time
      amount  + (((@stop_time - @start_time) / 60).ceil * @price_per_minute).round
    else
      amount  + (((Time.now - @start_time) / 60).ceil * @price_per_minute).round
    end
  end

  def one_sixth
    1.0 / 6.0
  end
end
