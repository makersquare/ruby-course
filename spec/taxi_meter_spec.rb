require './taxi_meter.rb'
require 'pry-debugger'

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
      stop_time = Time.now
      Time.stub(:now).and_return(stop_time)
      @meter.stop
      Time.stub(:now).and_return(stop_time + 5*60)
      expect(@meter.stop_time).to eq(stop_time)
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

    it "charges $2.50 for the first 1/6 mile (recorded in cents, not including time)" do
      #miles driven will be 1/6 of mile, and the time will be prorate at 0(fastcar)
      @meter.stop
      expect(@meter.stop).to eq(250)
    end

    it "charges $2.40 for each additional mile (recorded in cents, not including time)" do
      price_of_5_miles = @meter.stop(5)
      expect(price_of_5_miles).to eq(1410)
    end

    it "charges 2900 for the hour and doesn't drive anywhere" do
      start_time = Time.now
      Time.stub(:now).and_return(start_time)
      @meter.start
      stop_time = start_time + 60*60
      Time.stub(:now).and_return(stop_time)
      @meter.stop
      expect(@meter.stop).to eq(2900)
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

    it "has a minimum fare of $13.10"
  end

end
