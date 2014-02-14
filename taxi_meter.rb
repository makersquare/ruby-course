class TaxiMeter
  attr_reader :miles_driven, :start_time, :stop_time, :waiting_time, :airport

  def initialize(airport: false)
    @miles_driven = 0
    @start_time
    @stop_time
    @airport = airport
  end

  def amount_due
    miles_driven = @miles_driven
    if miles_driven > 0
      miles_driven = miles_driven - (1.0/6.0)
      amount_due = 250
    else
      amount_due = 0
    end
    if airport
      1310 + amount_due + (miles_driven * 240)
    elsif miles_driven <= 0
      amount_due
    else
      amount_due + (miles_driven * 240)
    end
  end

  def amount_due=(amount_due)
    @amount_due = amount_due
  end

  def miles_driven=(miles_driven)
    @miles_driven = miles_driven
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

end
