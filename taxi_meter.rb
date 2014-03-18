class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time

  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
    @airport = airport
  end

  def start
    @start_time = Time.now
  end

  def amount_due
    # WAITING TIME CALCULATION
    if @miles_driven == 0
        current_time = Time.now
        @amount_due += ((2900/60.0) * ((current_time-@start_time)/60.0)).floor
    # IF TRIP WAS ONLY 1/6 MILE
    elsif @miles_driven <= 1.0/6.0 && @miles_driven > 0
      @amount_due += 250
    # MILE CALCULATION BREAKDOWN
    elsif @miles_driven > 1.0/6.0
      # FIRST 1/6 MILE
      @amount_due += 250
      @miles_driven = (@miles_driven - 1.0/6.0).round(2)
      # ADDITIONAL MILES
      additional_miles = @miles_driven.floor
      @amount_due += (additional_miles*240)
      # FRACTIONS OF A MILE PRORATED TO 1/6 MILE
      if @miles_driven > additional_miles
        new_miles = (@miles_driven.modulo(1)).round(2)
          if new_miles < 0.17 && new_miles > 0
            @amount_due += 40
          elsif new_miles >= 0.17 && new_miles < 0.33
            @amount_due += 80
          elsif new_miles >= 0.33 && new_miles < 0.5
            @amount_due += 120
          elsif new_miles >= 0.5 && new_miles < 0.67
            @amount_due += 160
          elsif new_miles >= 0.67 && new_miles < 0.83
            @amount_due += 200
          elsif new_miles >= 0.83
            @amount_due += 240
          end
        end
    end
    # AIRPORT FARE?
    if @airport
      @amount_due += 1310
    end
    # ADDS ADDITIONAL $1 FOR EVERY TRIP BETWEEN 9PM AND 4AM
    if @start_time <= Time.parse('4am') || @start_time >= Time.parse('9pm')
      @amount_due += 100
    end
    # RETURN THE TOTAL AMOUNT DUE AFTER ALL CALCULATIONS
    @amount_due.round(2)
  end

  def stop
    @stop_time = Time.now
  end

end



