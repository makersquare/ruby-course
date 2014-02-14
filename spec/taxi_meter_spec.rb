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

    it "charges $2.50 for the first 1/6 mile (recorded in cents)" do
      expect(@meter.start).to eq(2.50)
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
      expect(@meter.start).to eq(13.10)
    end
  end

  context "The taxi can determine amount due based on miles driven" do
    before do
      # We want to freeze time to the point when the meter starts
      start_time = Time.now
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "can calculate amount due base on miles driven and waiting time" do
      @meter.miles_traveled(11.5)
      @waiting = @meter.waiting_time(90)
      @cost = @meter.total_cost

      expect(@cost).to eq(73.57)
    end
  end
  
  context "Adds additional fees after 9pm" do
    it "if between 9pm and 4am adds an additional $1 per mile" do
      start_time = Time.parse("10:00pm")
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
      @meter.miles_traveled(11.5)
      @waiting = @meter.waiting_time(90)
      @cost = @meter.total_cost

      expect(@cost).to eq(74.57)
    end
  end
end
