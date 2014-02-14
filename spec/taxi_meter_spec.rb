require './taxi_meter.rb'

describe TaxiMeter do

  def one_sixth
    1.0 / 6.0
  end

  describe "Basic functionality" do

    before do
      @meter = TaxiMeter.new
    end

    it "starts at zero" do
      @meter.amount_due = 0
      @meter.miles_driven = 0
    end

    it "can start and stop" do
      @meter.start
      expect(@meter.start_time).to_not be_nil
      expect(@meter.stop_time).to be_nil

      @meter.stop
      expect(@meter.stop_time).to_not be_nil
    end

    it "records the time it started" do
      # We want to freeze time to the point when the meter starts
      start_time = Time.now
      Time.stub(:now).and_return(start_time)

      # This should grab the current time
      @meter.start

      # Re-stub Time to be 5 minutes into the future
      Time.stub(:now).and_return(start_time + 5 * 60)

      # Once started, start_time shouldn't rely on the current time
      expect(@meter.start_time).to eq(start_time)
    end

    it "records the time it stopped" do
      #starts meter
      @meter.start

      #stubs time to add 15 minutes
      later = @meter.start_time + (15 * 60)
      Time.stub(:now).and_return(later)

      #stops meter using stubbed time
      @meter.stop

      #restub time to even later
      much_later = @meter.start_time + (30 * 60)
      Time.stub(:now).and_return(much_later)

      #stop_time should reflect stopped time
      expect(@meter.stop_time).to eq(later)
      expect(@meter.stop_time).to_not eq(@meter.start_time)
      expect(@meter.stop_time).to_not eq(much_later)
    end
  end

  context "The taxi meter starts" do
    before do
      # We want to freeze time to the point when the meter starts
      @start_time = Time.now
      Time.stub(:now).and_return(@start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "charges $2.50 for the first 1/6 mile (recorded in cents)" do
      #stops time to simulate end of trip
      @meter.stop

      #sets miles driven to exactly 1/6 mile
      @meter.miles_driven = 1.0 / 6.0

      # calculates price by miles driven expects inital 2.50 charge
      expect(@meter.amount_due).to eq(250)
    end

    it "charges $2.40 a miles prorated by 1/6" do
      #stops time to simulate end of trip
      @meter.stop_time

      #sets miles driven to number greater than min and not a whole number
      @meter.miles_driven = 30.854

      #calculates price by miles driven
      expect(@meter.amount_due).to eq(7400)
    end
  end


  context "The taxi meter starts from ABIA" do

    before do
      # We want to freeze time to the point when the meter starts
      start_time = Time.now
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new(airport: true)
      @meter.start
    end

    it "has a minimum fare of $13.10" do
      #stops time to simulate end of trip
      @meter.stop

      #sets milage to a small amount
      @meter.miles_driven = 3

      #calculates price based on miles expects airport minimum
      expect(@meter.amount_due).to eq(1310)

      # #sets milage to a large amount
      # @meter.miles_driven = 20

      # #calculates price based on miles expects normal fare
      # expect(@meter.amount_due).to eq(###)
    end
  end
end

