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
      # Freeze the stop time
      stop_time = Time.now
      Time.stub(:now).and_return(stop_time)

      # Return the current time
      @meter.stop

      # Re-stub Time to 10 minutes into the future
      Time.stub(:now).and_return(stop_time + (60*10))

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

    it "charges $2.40 for each additional mile, prorated by each 1/6 mile" do
      @meter.miles_driven = (2.0 + (3.0/7.0))
      expect(@meter.amount_due).to eq(810)
    end

    it "charges an additional $1 if started between 9pm and 4am" do
      new_time = Time.new(2014, 2, 1, 23, 0, 0)
      Time.stub(:now).and_return(new_time)
      @meter.miles_driven = one_sixth
      expect(@meter.amount_due).to eq(350)
    end

  end

  context "The waiting time" do
    before do
      @start_time = Time.now
      Time.stub(:now).and_return(@start_time)

      @meter = TaxiMeter.new
      @meter.start
      @meter.miles_driven = 0
    end

    it "charges $29 an hour for waiting" do
      new_time = @start_time + (60*60)
      Time.stub(:now).and_return(new_time)
      expect(@meter.amount_due).to eq(2900)
    end

    it "charges $14.5 for waiting a half hour" do
      new_time = @start_time + (60*30)
      Time.stub(:now).and_return(new_time)
      expect(@meter.amount_due).to eq(1450)
    end

    it "charges a prorated amount by the minute" do
      new_time = @start_time + (60*13)
      Time.stub(:now).and_return(new_time)
      expect(@meter.amount_due).to eq(628)
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
      @meter.miles_driven = 0
      expect(@meter.amount_due).to eq(1310)
    end

    it "adds on to an already started trip" do
      @meter.miles_driven = one_sixth
      expect(@meter.amount_due).to eq(1560)
    end

  end

end
