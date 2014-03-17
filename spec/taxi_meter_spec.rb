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
      start_time = Time.parse("Feb 24 2013 3 PM")
      Time.stub(:now).and_return(start_time)

      # This should grab the current time
      @meter.start

      # Re-stub Time to be 5 minutes into the future
      Time.stub(:now).and_return(start_time + 5 * 60)

      # Once started, start_time shouldn't rely on the current time
      expect(@meter.start_time).to eq(start_time)
    end

    it "records the time it stopped" do
      start_time = Time.parse("Feb 24 2013 3 PM")
      Time.stub(:now).and_return(start_time)

      # This should grab the current time
      @meter.start

      # Re-stub Time to be 5 minutes into the future
      Time.stub(:now).and_return(start_time + 5 * 60)
      @meter.stop

      expect(@meter.stop_time).to eq(start_time + 5 * 60)

    end
  end

  context "The taxi meter starts" do
    before do
      # We want to freeze time to the point when the meter starts
      start_time = Time.parse("Feb 24 2013 3 PM")
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "charges $2.50 for the first 1/6 mile (recorded in cents)" do
      @meter.miles_driven = 1.0 / 6.0


      expect(@meter.amount_due).to eq(250)
    end

    it "charges $2.40 for each additional mile, prorated by 1/6 of a mile" do
      @meter.miles_driven = 2.0 / 6.0

      expect(@meter.amount_due).to eq(290)
    end
  end


  context "The taxi meter starts from ABIA" do
    before do
      # We want to freeze time to the point when the meter starts
      start_time = Time.parse("Feb 24 2013 3 PM")
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new(airport: true)
      @meter.start
    end

    it "has a minimum fare of $13.10" do
      @meter.miles_driven = 4


      expect(@meter.amount_due).to eq(1310)
    end
  end

  context "The taxi meter adds charges for time" do
    before do

      @meter = TaxiMeter.new
      start_time = Time.parse("Feb 24 2013 3 PM")
      Time.stub(:now).and_return(start_time)
      @meter.start
      new_time = start_time + (60 * 60)
      Time.stub(:now).and_return(new_time)

    end

    it "adds $29.00 an hour, prorated in minutes to wait times" do
      @meter.miles_driven = 0 # $2.50 regardless
      @meter.stop
      expect(@meter.amount_due).to eq(3150)
    end
  end

  context "The taxi meter starts between 9pm and 4am" do
    before do
      # We want to freeze time to between 9am and 4pm
      start_time = Time.parse("Feb 24 2013 3 AM")
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "adds $1.00 if the time is between 9pm and 4am" do
      @meter.miles_driven = 2.0 / 6
      @meter.stop
      expect(@meter.amount_due).to eq(390)
    end
  end

  context "The taxi meter stops running after the stop time" do

    it "doesn't add more time after the meter stops running" do
      start_time = Time.parse("Feb 24 2013 3 PM")
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
      stop_time = Time.parse("Feb 24 2013 4 PM")
      Time.stub(:now).and_return(stop_time)
      @meter.miles_driven = 0
      @meter.stop
      time_later = Time.parse("Feb 24 2013 5 PM")
      Time.stub(:now).and_return(time_later)

      expect(@meter.amount_due).to eq(3150)

    end
  end

end
