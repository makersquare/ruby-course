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
      @meter.start
      time = Time.now
      Time.stub(:now).and_return(time + 5 * 60)
      @meter.stop
      expect(@meter.stop_time).to eq(time + 5 * 60)
    end

    it "doesn't change the start time if started again" do
      start_time = Time.now
      Time.stub(:now).and_return(start_time)
      @meter.start
      Time.stub(:now).and_return(start_time + 5 * 60)
      @meter.start
      expect(@meter.start_time).to eq(start_time)
    end
  end #context

  context "The taxi meter starts" do
    before do
      # We want to freeze time to the point when the meter starts
      @start_time = Time.now
      Time.stub(:now).and_return(@start_time)
      @meter = TaxiMeter.new
      @meter.start
    end

    #binding.pry

    it "charges $2.50 for the first 1/6 mile (recorded in cents)" do
      @meter.miles_driven = one_sixth
      expect(@meter.amount_due).to eq(250)
    end

    it "rounds up for miles driven" do
      @meter.miles_driven = 0.01
      expect(@meter.amount_due).to eq(250)

      @meter.miles_driven = one_sixth  + 0.01
      expect(@meter.amount_due).to eq(290)
    end

    it "charges $2.40 for each additional mile (prorated by each sixth)" do
      @meter.miles_driven = one_sixth * 2
      expect(@meter.amount_due).to eq(290)

      @meter.miles_driven = 10 + one_sixth
      expect(@meter.amount_due).to eq(2650)

      @meter.miles_driven = 1.5
      expect(@meter.amount_due).to eq(570)

      @meter.miles_driven = one_sixth * 7
      expect(@meter.amount_due).to eq(490)


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
      expect(@meter.amount_due).to eq(1310)
    end

    it "doesn't always use the minimum fare" do
      @meter.miles_driven = 10 + one_sixth
      expect(@meter.amount_due).to eq(2650)
    end

  end #end context

  context "The taxi meter should have a rolling balance" do
    before do
      time = Time.now
      Time.stub(:now).and_return(time)
      @meter = TaxiMeter.new
      @meter.start
    end

    it "should have a fare based on elapsed time" do
      time = Time.now
      Time.stub(:now).and_return(time + 5 * 60)
      expect(@meter.amount_due).to eq(492)
    end

    it "should have a waiting time fare of $29.00 an hour" do
      time = Time.now
      Time.stub(:now).and_return(time + 60 * 60)
      expect(@meter.amount_due).to eq(3150)
    end

    it "should have a waiting time fare of $29.48 for 1 hour 1 min" do
      time = Time.now
      Time.stub(:now).and_return(time + 61 * 60)
      expect(@meter.amount_due).to eq(3198)
    end

    it "should calculate elapsed time and distance together" do
      time = Time.now
      Time.stub(:now).and_return(time + 5 * 60)
      @meter.miles_driven = 1.5
      expect(@meter.amount_due).to eq(812)
    end

    it "should calculate based on start time, stop time, and distance" do
      time = Time.now
      Time.stub(:now).and_return(time + 5 * 60)
      @meter.miles_driven = 1.5
      @meter.stop
      Time.stub(:now).and_return(time + 10 * 60)
      expect(@meter.amount_due).to eq(812)
    end

    it "should retain stop time even if stop is called again" do
      time = Time.now
      Time.stub(:now).and_return(time + 5 * 60)
      @meter.miles_driven = 1.5
      @meter.stop
      Time.stub(:now).and_return(time + 10 * 60)
      @meter.stop
      expect(@meter.amount_due).to eq(812)
    end

    it "Makes sure that you can't stop time that hasn't been started" do
    @meter = TaxiMeter.new
    @meter.stop

    expect(@meter.stop_time).to be_nil
  end


  end #end context

    context "The taxi meter should add a dollar if start time is between 9pm and 4am" do
    before do
      @time = Time.now
      Time.stub(:now).and_return(Time.parse("2014-2-15 21:00:00"))
      @meter = TaxiMeter.new
      @meter.start
    end

      it "should add a dollar if start time after 9pm " do
      Time.stub(:now).and_return(Time.parse("2014-2-15 21:05:00"))
      expect(@meter.amount_due).to eq(592)
    end

    it "from AIBA minimum fare of $14.10 after 9pm" do
      @meter = TaxiMeter.new(airport: true)
      @meter.start
      Time.stub(:now).and_return(Time.parse("2014-2-15 21:05:00"))
      expect(@meter.amount_due).to eq(1410)
    end

    it "doesn't always use the minimum fare from the airport" do
      @meter = TaxiMeter.new(airport: true)
      @meter.start
      Time.stub(:now).and_return(Time.parse("2014-2-15 21:05:00"))
      @meter.miles_driven = 10 + one_sixth
      expect(@meter.amount_due).to eq(2992)
    end

  end #end context


end #end class
