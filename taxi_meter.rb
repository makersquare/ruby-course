
class TaxiMeter

  attr_accessor :meter, :miles_driven, :start_time, :stop_time, :amount_due

  def initialize
    @meter = meter
    @miles_driven = 0
    @start_time = start_time
    @stop_time = stop_time
    @amount_due = 0
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
    #calling stop calls amount due, resets meter, miles driven, startime, etcs
  end

  def amount_due
    time = Time.now
    always_one_sixth = 1.0/6.0
    price = (@miles_driven*6)*40 + 210
    if @miles_driven == 0
      return 0
    else
      return price.ceil
    end
  end




    # waiting_cost_per_hour = 2900.0
    # always_one_sixth = 0.16666666666
    # time_traveled_in_minutes = (@start_time-@stop_time)/60
    # cost_of_waiting = waiting_cost_per_hour * (time_traveled_in_minutes/60)


    # 250 for first1/6, 240 each additional prorated

end
