class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time
  attr_reader :airport

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
    if @miles_driven == 0 && @airport == false
      0
    elsif @miles_driven == 1.0 / 6.0 && @airport == false
      2.5
    elsif @miles_driven == 1.0 / 6.0 && @airport == true
      (2.5 + 13.1)
    elsif @airport == true
      ((2.5 + 2.4 * (@miles_driven - (1.0 / 6.0))) + 13.1).round(1)
    else
      (2.5 + 2.4 * (@miles_driven - (1.0 / 6.0))).round(1)
    end
  end
end
