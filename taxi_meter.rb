

class TaxiMeter

  attr_reader :start_time, :stop_time
  attr_accessor :amount_due, :miles_driven

  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
    @airport = airport
  end

  def one_sixth
    1.0 / 6.0
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def twilight_charge
      if !@start_time.nil?
        hour = @start_time.hour
        if hour.between?( 21, 24) || hour.between?( 0, 4)
          @amount_due += 100
      end
    end
  end

  def time_based_cost
    if @stop_time.nil?
      calculate_at_time = Time.now
    else
      calculate_at_time = @stop_time
    end
    minutes = ((calculate_at_time - @start_time) / 60).ceil
    charge_by_minutes = (minutes * (2900.0 / 60.0)).ceil
    @amount_due += charge_by_minutes
  end

  def distance_based_cost
    @amount_due += 250
    if @miles_driven > one_sixth
      num_of_charge_points = ((@miles_driven - one_sixth) / one_sixth).round(3).ceil
      current_mile_charge = ((num_of_charge_points * 0.40) * 100).floor
      @amount_due += current_mile_charge
    end
  end

  def airport_charge
    if @airport
      if @amount_due < 1310
        @amount_due = 1310
      end
    end
  end

  def amount_due
    @amount_due = 0
    if !@start_time.nil?
      twilight_charge
      time_based_cost
      distance_based_cost
      airport_charge
    end
    @amount_due
  end
end

