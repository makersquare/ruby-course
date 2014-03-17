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
      # Don't change this test;
      # amount_due and miles_driven are required to work this way
      expect(@meter.amount_due).to eq 0
      expect(@meter.miles_driven).to eq 0
    end

    it "cannot set amount due" do
      expect { @meter.amount_due = 99 }.to raise_error
    end

    it "cannot set start time nor stop time" do
      expect { @meter.start_time = Time.now }.to raise_error
      expect { @meter.stop_time = Time.now }.to raise_error
    end

    it "can specify miles driven" do
      @meter.miles_driven = 5
      expect(@meter.miles_driven).to eq 5
    end

    it "can start and stop" do
      # Don't change this test;
      # start and stop are required to work this way
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
      @meter.stop
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
      @meter.miles_driven = 1.0/6
      @meter.start_time = Time.new(2014, 2, 1, 11, 0, 0)
      @meter.stop_time = Time.new(2014, 2, 1, 11, 0, 0)
      expect(@meter.amount_due).to eq(250)
    end
    it "charges $40.70 for 4 miles (recorded in cents)" do    
      @meter.miles_driven = 4
      @meter.start_time = Time.new(2014, 2, 1, 11, 0, 0)
      @meter.stop_time = Time.new(2014, 2, 1, 12, 0, 0)
      expect(@meter.amount_due).to eq(4070)
    end

    it "charges $29.00 for an hour of elapsed time" do 
      @meter.miles_driven = 0
      @meter.start_time = Time.new(2014, 2, 1, 11, 0, 0)
      @meter.stop_time = Time.new(2014, 2, 1, 12, 0, 0)
      expect(@meter.amount_due).to eq(3150)
    end
    it "charges $32.50 for a 1-hour fare starting at 2am" do 
      @meter.miles_driven = 0
      @meter.start_time = Time.new(2014, 2, 1, 2, 0, 0)
      @meter.stop_time = Time.new(2014, 2, 1, 3, 0, 0)
      expect(@meter.amount_due).to eq(3250)
    end
  end


  context "The taxi meter starts from ABIA" do
    before do
      # We want to freeze time to the point when the meter starts
      @start_time = Time.now
      Time.stub(:now).and_return(@start_time)
      @meter = TaxiMeter.new(airport: true)
      @meter.start
    end

    it "has a minimum fare of $13.10 for airport rides" do
      @meter.miles_driven = 0
      @meter.start_time = Time.new(2014, 2, 1, 11, 0, 0)
      @meter.stop_time = Time.new(2014, 2, 1, 11, 15, 0)
      expect(@meter.amount_due).to eq(1310)
    end
    it "has a minimum fare of $13.10 for airport rides" do
      @meter.miles_driven = 1.0/6
      @meter.start_time = Time.new(2014, 2, 1, 11, 0, 0)
      @meter.stop_time = Time.new(2014, 2, 1, 11, 15, 0)
      expect(@meter.amount_due).to eq(1310)
    end
    it "charges $40.70 at the end of a 4-mile, 1-hour fare" do
      @meter.miles_driven = 4
      @meter.start_time = Time.new(2014, 2, 1, 11, 0, 0)
      @meter.stop_time = Time.new(2014, 2, 1, 12, 0, 0)
      expect(@meter.amount_due).to eq(4070)
    end
    it "charges $40.70 during a 4-mile, 1-hour fare" do
      @meter.miles_driven = 4
      @meter.start_time = Time.now-3600
      expect(@meter.amount_due).to eq(4070)
    end
    it "rounds up to the next 1/6th of a mile" do
      @meter.miles_driven = 0.5
      @meter.start_time = Time.now-3600
      expect(@meter.amount_due).to eq(3230)
    end
    it "rounds up to the next 1/6th of a mile" do
      @meter.miles_driven = 0.55
      @meter.start_time = Time.now-3600
      expect(@meter.amount_due).to eq(3270)
    end
    it "rounds up to the next 1/6th of a mile" do
      @meter.miles_driven = 4.0/6
      @meter.start_time = Time.now-3600
      expect(@meter.amount_due).to eq(3270)
    end
    it "rounds up to the next 1/6th of a mile" do
      @meter.miles_driven = 0.7
      @meter.start_time = Time.now-3600
      expect(@meter.amount_due).to eq(3310)
    end
    it "doesn't charge anything miles for negative miles" do
      @meter.miles_driven = -1.0
      @meter.start_time = Time.now-3600
      expect(@meter.amount_due).to eq(3150)
    end
    it "doesn't charge anything miles for negative miles" do
      @meter.miles_driven = -1.0
      @meter.start_time = Time.now-3600
      expect(@meter.amount_due).to eq(3150)
    end
    it "doesn't charge anything miles for negative miles" do
      @meter.miles_driven = -1.0
      @meter.start_time = Time.now-3600
      expect(@meter.amount_due).to eq(3150)
    end
    it "charges $13.10 for a 10-minute airport fare starting at 2am" do 
      @meter.miles_driven = 0
      @meter.start_time = Time.new(2014, 2, 1, 2, 0, 0)
      @meter.stop_time = Time.new(2014, 2, 1, 2, 10, 0)
      expect(@meter.amount_due).to eq(1310)
    end
  end
end
