class TaxiMeter

	attr_accessor :meter, :amount_due, :miles_driven
  
  def initialize
  	@meter=meter
  	@amount_due=amount_due
  	@miles_driven=miles_driven
  end

  def amount_due
  	@amount_due=0
  end

  def miles_driven
  	@miles_driven=0
  end


  	
end
