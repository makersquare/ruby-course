class TaxiMeter
  attr_accessor :amount_due, :miles_driven
  attr_reader :airport, :elapsed_time, :start_time, :stop_time

  def initialize(airport: false)
    @airport = airport
    @amount_due = 0
    @miles_driven = 0

  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def amount_due
    if @start_time.hour < 9 || start_time.hour > 16
      check_for_surcharges
    else
      check_for_surcharges + 1
    end
  end

  def check_for_surcharges
    if @miles_driven == 0 && @airport == false
      amount = 0
    elsif @miles_driven == 1.0 / 6.0 && @airport == false
      amount = 2.5
    elsif @miles_driven == 1.0 / 6.0 && @airport == true
      amount = (2.5 + 13.1)
    elsif @airport == true
      amount = ((2.5 + 2.4 * (@miles_driven - (1.0 / 6.0))) + 13.1)
    else
      amount = ((2.5 + 2.4 * (@miles_driven - (1.0 / 6.0))))
    end

    if @stop_time
      amount.round(2)  + ((@stop_time - @start_time) / 60 * (29.0/60)).round(2)
    else
      amount.round(2)  + ((Time.now - @start_time) / 60 * (29.0/60)).round(2)
    end
  end
end
