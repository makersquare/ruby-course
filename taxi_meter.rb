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
    # ADDS ADDITIONAL $1 FOR EVERY TRIP BETWEEN 9PM AND 4AM

    # WAITING TIME CALCULATION
    if @miles_driven == 0
        current_time = Time.now
        @amount_due += (29.0/60.0) * ((current_time-@start_time)/60.0)
    # IF TRIP WAS ONLY 1/6 MILE
    elsif @miles_driven <= 1.0/6.0 && @miles_driven > 0
      @amount_due += 2.50
    # MILE CALCULATION BREAKDOWN
    elsif @miles_driven > 1.0/6.0
      # FIRST 1/6 MILE
      @amount_due += 2.50
      @miles_driven = (@miles_driven - 1.0/6.0).round(2)
      # ADDITIONAL MILES
      additional_miles = @miles_driven.floor
      @amount_due += (additional_miles*2.40)
      # FRACTIONS OF A MILE PRORATED TO 1/6 MILE
      if @miles_driven > additional_miles
        new_miles = (@miles_driven.modulo(1)).round(2)
          if new_miles < 0.17 && new_miles > 0
            @amount_due += 0.40
          elsif new_miles >= 0.17 && new_miles < 0.33
            @amount_due += 0.80
          elsif new_miles >= 0.33 && new_miles < 0.5
            @amount_due += 1.20
          elsif new_miles >= 0.5 && new_miles < 0.67
            @amount_due += 1.60
          elsif new_miles >= 0.67 && new_miles < 0.83
            @amount_due += 2.00
          elsif new_miles >= 0.83
            @amount_due += 2.40
          end
        end
    end
    # AIRPORT FARE?
    if @airport
      @amount_due += 13.10
    end
    # RETURN THE TOTAL AMOUNT DUE AFTER ALL CALCULATIONS
    @amount_due.round(2)
  end

  def stop
    @stop_time = Time.now
  end

end



