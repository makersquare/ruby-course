require 'pry'

class TaxiMeter

  attr_accessor :miles_driven, :start_time, :stop_time, :airport
  attr_writer :amount_due

  def initialize(airport: false)
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
    @wait_time = 0
    @airport = airport
    @amount_due = 0
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def amount_due
    # sprintf("%.2f",item[:price].to_f * item[:quantity])

    charge_per_sixth = 2.40 / 6.0

    if @miles_driven == 0
      total_charge = 0.00
    elsif @miles_driven <= (1.0/6.0)
      total_charge = 2.50
    else
      # if ((@miles_driven - (1.0/6.0)) / (1.0/6.0)) % 1.0 == 0
        total_charge = (@miles_driven * 6).ceil * charge_per_sixth + 2.10
      # else 5.7
        # total_charge = (@miles_driven - (1.0/6.0)) / (1.0/6.0) * charge_per_sixth + charge_per_sixth + 2.50
      # end
    end

    charge_per_wait_min = 29.00 / 60

    if @start_time && @stop_time.nil?
      @wait_time = Time.now - @start_time
      wait_charge = (@wait_time / 60).ceil * charge_per_wait_min
      total_charge += wait_charge

      if @start_time.hour < 4 || @start_time.hour >= 21
        total_charge += 1.00
      end
    end

    if @start_time && @stop_time
      @wait_time = @stop_time - @start_time
      wait_charge = (@wait_time / 60).ceil * charge_per_wait_min
      total_charge += wait_charge

      if @start_time.hour < 4 || @start_time.hour >= 21
        total_charge += 1.00
      end
    end

    if @airport && total_charge < 13.10
      total_charge = 13.10
    end

    (total_charge*100).round
  end
end

class Float
  def ceil_to(x)
    # Rounds up to the nearest x decimal place
    (self * 10**x).ceil.to_f / 10**x
  end
end

