gem 'rspec', '~> 2.14.0'
gem 'pry-debugger', '~> 0.2.2'

class TaxiMeter
  attr_accessor :miles_driven, :amount_due
  attr_reader :start_time, :stop_time, :sixth

  def initialize()
    @miles_driven = 0
    @sixth = 1.0 / 6.0
    @base_charge = 210
    @additional_sixth = 40
  end

  def start
    @start_time = Time.now
  end

  def stop
    if @start_time
    @stop_time = Time.now
  end
  end



  def amount_due
    fare = 0
    if @miles_driven == 0 
      fare
    else
      # Divide miles driven into sixths 
      # and remove the first sixth
      prorated = (@miles_driven / @sixth).ceil 

      fare = @base_charge+ prorated* @additional_sixth
    end

    fare
  end
end