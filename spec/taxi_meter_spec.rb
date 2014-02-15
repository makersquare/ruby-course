require 'pry-debugger'
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
      start_time = Time.now
      Time.stub(:now).and_return(start_time)

      @meter.start

      Time.stub(:now).and_return(start_time + 5 * 60)

      @meter.stop

      expect(@meter.stop).to eq(start_time + 5 * 60)
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


      expect(@meter.amount_due).to eq(250) # 250 centers or $2.50
    end

    it "charges $2.40 for each additional mile (prorated by each sith)" do
      @meter.miles_driven = one_sixth * 2
      expect(@meter.amount_due).to eq(290)

      @meter.miles_driven = 10 + one_sixth
      expect(@meter.amount_due).to eq(2650)

      @meter.miles_driven = one_sixth * 20
      expect(@meter.amount_due).to eq(1010)

      @meter.miles_driven = 1.5
      expect(@meter.amount_due).to eq(570)

      # @meter.miles_driven = one_sixth * 20 + 0.1
      # expect(@meter.amount_due).to eq(1050)
    end

    it "charges $6.90 for 2 miles (recorded in cents)" do
      @meter.miles_driven = 2


      expect(@meter.amount_due).to eq(690)
    end
  end

  context "The taxi meter ends" do
    before do
      @meter = TaxiMeter.new
      start_time = Time.now
      Time.stub(:now).and_return(start_time)

      @meter.start

      Time.stub(:now).and_return(start_time + 60 * 60)

      @meter.stop

      expect(@meter.stop).to eq(start_time + 60 * 60)
    end

    it "should charge $29.00 for an hour wait time (recorded in cents" do
      expect(@meter.amount_due).to eq(2900)
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

    it "has a minimum fare of $13.10" do #actually checking for 13.10 plus 2.50 charge
      expect(@meter.amount_due).to eq(1310)
    end
  end

  context "The taxi meter is running between 9pm and 4am" do
    before do
      start_time = Time.parse("9 pm")
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start

      @meter.miles_driven = 1.5 # meter#amount_due #=> 570 + 100 (cents) for after hours charge
    end

    it "should charge $1 extra" do
      expect(@meter.amount_due).to eq(670)
    end
  end
end
