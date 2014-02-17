require './taxi_meter.rb'
require 'pry-debugger'
require 'time'

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
      # Stub the stopping time
      stop_time = Time.now
      Time.stub(:now).and_return(stop_time)

      # This should grab the current time
      @meter.stop

      # Re-stub Time to be 5 minutes into the future
      Time.stub(:now).and_return(stop_time + 5 * 60)

      # Once started, start_time shouldn't rely on the current time
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

      @meter.miles_driven = one_sixth
      expect(@meter.amount_due).to eq(250)
    end

    it "charges $2.40 for each additional mile (prorated by each sixth)" do
      @meter.miles_driven = one_sixth * 2
      expect(@meter.amount_due).to eq(290)

      @meter.miles_driven = 10 + one_sixth
      expect(@meter.amount_due).to eq(2650)

      @meter.miles_driven = one_sixth * 20
      expect(@meter.amount_due).to eq(1010)

      # Make sure it rounds up to gouge as
      # much money from the customer as possible
      # @meter.miles_driven = one_sixth * 20 + 0.1
      # expect(@meter.amount_due).to eq(1050)
    end

    it "$29.00 an hour for waiting time, prorated by minute" do
      # For one hour
      Time.stub(:now).and_return(@start_time + 60 * 60)
      expect(@meter.amount_time).to eq(2900)

      # For two hours
      Time.stub(:now).and_return(@start_time + 60 * 60 * 2)
      expect(@meter.amount_time).to eq(5800)
    end

    it "charges $33.50 for an hour of time and one mile of travel" do
      Time.stub(:now).and_return(@start_time + 60 * 60)
      @meter.miles_driven = 1
      expect(@meter.amount_due).to eq(3350)
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

    xit "has a minimum fare of $13.10" do

      @meter.miles_driven = one_sixth * 20
      expect(@meter.amount_due).to eq(1310)

      @meter.miles_driven = 10 + one_sixth
      expect(@meter.amount_due).to eq(2650)


      Time.stub(:now).and_return(@meter.start_time + 60)
      @meter.miles_driven = one_sixth * 20
      expect(@meter.amount_due).to eq(1310)
    end
  end
  context "Between 9pm and 4am" do
    before do
      # We want to freeze time to the point when the meter starts
      start_time = Time.parse('9pm')
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    xit "charges an extra $1" do
      Time.stub(:now).and_return(@meter.start_time + 60 * 60)
      @meter.miles_driven = 1
      expect(@meter.amount_due).to eq(3450)
    end
  end
end
