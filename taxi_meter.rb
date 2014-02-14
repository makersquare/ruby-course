require 'time'

class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time
  # TODO

  def initialize
    @amount_due = 0
    @miles_driven = 0
  end

  def calc_due(miles_driven)
    sixth = miles_driven * 6
    puts "#{sixth}"

    @amount_due = (210 + (40 * sixth))


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
