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
      expect(@meter.amount_due).to eq(0)
      expect(@meter.miles_driven).to eq(0)
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
    # Stub the stop time
      stop_time = Time.now
      Time.stub(:now).and_return(stop_time)

      @meter.stop

      expect(@meter.stop_time).to eq(stop_time)
    end

    it "records the passage of time" do
      # Freeze time to the point when the meter starts
      start_time = Time.now
      Time.stub(:now).and_return(start_time)

      # This should grab the current time
      @meter.start

      # Re-stub Time to be 5 minutes into the future
      Time.stub(:now).and_return(start_time + 5 * 60)

      # Stop should grab the later time
      @meter.stop

      # Test stop time
      expect(@meter.stop_time).to eq(start_time + 5 * 60)
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
      @meter.miles_driven = one_sixth
      @meter.stop
      expect(@meter.amount_due).to eq(250)
    end

    it "charges an additional $1.00 (recorded in cents) if the start time is between 9am and 4pm" do
      @meter.miles_driven = one_sixth
      @meter.stop
      expect(@meter.amount_due).to eq(350)
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

    it "has a minimum fare of $13.10 (recorded in cents)" do
      @meter.miles_driven = one_sixth
      @meter.stop
      expect(@meter.amount_due).to eq(1560)
    end
  end

end
