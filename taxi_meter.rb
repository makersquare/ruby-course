
class TaxiMeter

  attr_accessor :meter, :miles_driven, :start_time, :stop_time, :amount_due, :airport

  def initialize
    @meter = meter
    @miles_driven = 0
    @start_time = start_time
    @stop_time = stop_time
    @amount_due = amount_due
    @airport = false
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
    #calling stop calls amount due, resets meter, miles driven, startime, etcs
  end

  def amount_due
    if extra_hour?
      price = (@miles_driven*6)*40 + 210 + 100
    else
      price = (@miles_driven*6)*40 + 210
    end
    if @airport == false
      if @miles_driven == 0
        return 0
      else
        return price.round + amount_time
      end
    elsif @airport == true
      if (price.round + amount_time) > 1310
        return price.round + amount_time
      else
        return 1310
      end
    end
  end

  def amount_time
    time = Time.now
    minutes_elapsed = (-1*(@start_time - time)/60).round
    amount_from_time_lapsed = 2900.0*minutes_elapsed/60
    return amount_from_time_lapsed
  end


  def extra_hour?
    #need to add a method under true that multiples all price values by 0.5
    if (Time.now.hour >= 21 || Time.now.hour <=4)
      return true
    else
      return false
    end
  end

end
