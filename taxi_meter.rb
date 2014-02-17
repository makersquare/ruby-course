gem 'rspec', '~> 2.14.0'
gem 'pry-debugger', '~> 0.2.2'

class TaxiMeter
  attr_accessor :miles_driven, :amount_due, :start_time, :stop_time, :wait_time
  attr_reader :stop_time, :sixth

  def initialize(airport: false)
    @airport = airport
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
    if @start_time
      #adds drunk_tax to amount due if start_time (9pm - 4am)
      if @start_time.hour > 21 || @start_time.hour < 4
        additional_charges + 100
      else
        additional_charges
      end
    else
      0
    end
  end

  def additional_charges
    if @start_time != nil #only runs calcs if start time initialized
      # sets base charge for < 1/6 mile distance
      if @miles_driven <= @sixth 
      @amount_due = 250
      #calculates amount_due based upon distance traveled
      else
        prorated = (@miles_driven / @sixth).ceil
        @amount_due = @base_charge + prorated * @additional_sixth
      end
      #calculates wait time and adds to amount_due
      if @stop_time 
        @amount_due += wait_time*((@stop_time-@start_time)/60).ceil
      else
        @amount_due += wait_time*((Time.now-@start_time)/60).ceil
      end
      
      #sets minimum charge of 1310 if origin == airport
      @amount_due = 1310 if @airport && @amount_due < 1310
      #returns amount due
      @amount_due.round(0)
    else
      0
    end          
  end
end