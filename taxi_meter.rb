gem 'rspec', '~> 2.14.0'
gem 'pry-debugger', '~> 0.2.2'

class TaxiMeter
  attr_accessor :miles_driven, :amount_due, :start_time, :stop_time, :wait_time
  attr_reader :stop_time, :sixth

  def initialize()
    @miles_driven = 0
    @sixth = 1.0 / 6.0
    @base_charge = 210
    @additional_sixth = 40
    @wait_time = 2900.0 / 60.0
    @start_time = nil
    @stop_time = nil

  end

  def start
    @start_time = Time.now
  end

  def stop
    if @start_time
    @stop_time = Time.now
    end
  end
def time
    if @stop_time
      @stop_time
    else
      Time.now
    end
  end
  def amount_due
    if @start_time != nil 
      if @miles_driven <= @sixth 
      @amount_due = 250
      else
        prorated = (@miles_driven / @sixth).ceil
        fare = @base_charge + prorated * @additional_sixth
        @amount_due = fare
      end

      if @stop_time 
        @amount_due += wait_time*((@stop_time-@start_time)/60).ceil
      else
        @amount_due += wait_time*((Time.now-@start_time)/60).ceil
      end
      @amount_due += 100 if (@start_time.hour >= 21 || @start_time.hour < 4)
        @amount_due.round(0)
    else
      0
    end          
  end
end