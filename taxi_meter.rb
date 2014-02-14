
class TaxiMeter

  attr_accessor :meter, :total_cost, :miles_driven, :start_time, :stop_time, :amount_due

  def initialize
    @meter = meter
    @amount_due = 0
    @miles_driven = 0
    @start_time = start_time
    @stop_time = stop_time
  end

  def start
    @start_time = Time.now
  end

  def stop(miles_driven=0)
    @stop_time = Time.now
    waiting_cost_per_hour = 2900
    always_one_sixth = 0.16666666666
    @stop_time = Time.now
    time_traveled_in_minutes = (@start_time-@stop_time)/60
    cost_of_waiting = waiting_cost_per_hour * (time_traveled_in_minutes/60)
    # 250 for first1/6, 240 each additional prorated
    price = (250 + 240*(miles_driven-always_one_sixth))
    if miles_driven<=always_one_sixth
      return @amount_due = 250
    else
      @amount_due = price
      return (@amount_due).floor
    end
  end




end
