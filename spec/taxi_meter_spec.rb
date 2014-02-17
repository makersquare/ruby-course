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
      time = Time.now
      Time.stub(:now).and_return(time)
      @meter.start

      new_time = time + (5 * 60)
      Time.stub(:now).and_return(new_time)
      @meter.stop

      expect(@meter.stop_time).to eq(new_time)
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
      @meter.miles_driven = 1.0 / 6.0

      expect(@meter.amount_due).to eq(250)
    end

  end

  context "The taxi meter is running" do

    before do
      @meter = TaxiMeter.new
    end

    it "charges $2.40 for each additional mile, prorated by each 1/6 mile" do
      @start_time = Time.parse("2014-02-11 07:00:00 -0600")
      Time.stub(:now).and_return(@start_time)
      @meter.start
      @meter.miles_driven = (2 + (2.0 / 6.0)) + (1.0 / 8.0)

      expect(@meter.amount_due).to eq(810)
    end

    it "charges additional dollar if start time between 9pm and 4am" do
      @three_am = Time.parse("2014-02-11 03:00:00 -0600")
      Time.stub(:now).and_return(@three_am)
      @meter.start
      new_time = @three_am + (40 * 60)
      Time.stub(:now).and_return(new_time)
      @meter.miles_driven = 10

      expect(@meter.amount_due).to eq(4643)
    end

    it "charges $29.00 an hour for waiting time, prorated by minute" do
      @seven_pm = Time.parse("2014-02-11 19:00:00 -0600")
      Time.stub(:now).and_return(@seven_pm)
      @meter.start
      time = @seven_pm + (40 * 60)
      Time.stub(:now).and_return(time)
      @meter.miles_driven = 10

      expect(@meter.amount_due).to eq(4543)
    end

  end

  context "The taxi meter is stopped" do
    before do
      @meter = TaxiMeter.new
      @seven_pm = Time.parse("2014-02-11 19:00:00 -0600")
      Time.stub(:now).and_return(@seven_pm)
      @meter.start
    end

    it "gives correct amount due after meter stops" do
      @meter.miles_driven = 10
      new_time = Time.parse("2014-02-11 19:40:00 -0600")
      Time.stub(:now).and_return(new_time)
      @meter.stop
      Time.stub(:now).and_return(@meter.start_time + 80 * 60)

      expect(@meter.amount_due).to eq(4543)
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

    it "has a minimum fare of $13.10" do
      time = @start_time + (2 * 60)
      Time.stub(:now).and_return(time)
      @meter.miles_driven = 2

      expect(@meter.amount_due).to eq(1310)
    end

  end

end





