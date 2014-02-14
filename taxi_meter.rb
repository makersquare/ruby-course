require 'time'

class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time
  # TODO

  def initialize
    @amount_due = 0
    @miles_driven = 0
  end

  def calc_due(miles_driven)
     if miles_driven == 1.0 / 6.0
       @amount_due = sprintf('%.2f', 2.50)
     else miles_driven > 1.0
       calc_minus_first = (miles_driven - 1.0) / 6.0
       puts "#{calc_minus_first}"
       @amount_due = sprintf('%.2f', 2.50 + (0.4 * calc_minus_first))
     end

  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def distance(miles_driven)
    @miles_driven = miles_driven
    @amount_due = self.calc_due(miles_driven)
  end



end #end TaxiMeter
