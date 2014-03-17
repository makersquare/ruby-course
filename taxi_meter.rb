class TaxiMeter
  attr_accessor :start_time, :stop_time
  attr_reader :miles_driven, :waiting_time, :airport

  def initialize(airport: false)
    @miles_driven = 0
    @start_time
    @stop_time
    @airport = airport
    @meter_started = false
  end

  def amount_due
    miles_driven = @miles_driven
    miles_driven = (miles_driven * 6).ceil
    if @stop_time != nil && @start_time != nil
      elapsed_time_in_minutes = (@stop_time - @start_time)/60
    elsif start_time != nil && stop_time == nil
      elapsed_time_in_minutes = (Time.now - @start_time)/60
    else
      elapsed_time_in_hours = 0
    end

    if miles_driven > 0
      miles_driven = miles_driven - 1 #Subtracts a 1/6mile unit from the total
      amount_due = 250 + elapsed_time_in_minutes.ceil * 2900/60.0
    else
      amount_due = elapsed_time_in_minutes.ceil * 2900/60.0
    end

    if start_time.hour >= (12+9)
      amount_due = amount_due + 100
    elsif start_time.hour <=4
      amount_due = amount_due + 100
    end

    if airport
      amount_due = amount_due + (miles_driven * 40)
      if amount_due < 1310
        amount_due = 1310
      end
    elsif miles_driven <= 0
      amount_due
    else
      amount_due = amount_due + (miles_driven * 40)
    end
    amount_due.ceil
  end

  def amount_due=(amount_due)
    @amount_due = amount_due
  end

  def miles_driven=(miles_driven)
    @miles_driven = miles_driven
  end

  def start
    @start_time = Time.now
    @meter_started = true
  end

  def stop
    if @meter_started
      @stop_time = Time.now
    else
      puts "The meter hasn't been started yet."
    end
  end

end
