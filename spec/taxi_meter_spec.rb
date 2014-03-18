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

    it "doesn't stop time if time hasn't been started" do

      @meter.stop
      expect(@meter.stop_time).to eq(nil)
    end

    it "records the time it stopped" do
      # We want to freeze time to the point when the meter starts
      stop_time = Time.now
      Time.stub(:now).and_return(stop_time)

      @meter.start #Added this line because you shouldn't be able to stop time if time hasn't been started
      # This should grab the current time
      @meter.stop

      # Re-stub Time to be 5 minutes into the future
      Time.stub(:now).and_return(stop_time + 5 * 60)

      # Once started, start_time shouldn't rely on the current time
      expect(@meter.stop_time).to eq(stop_time)
    end


  end

  context "The taxi meter starts and no drunk tax" do
    before do
      # We want to freeze time to the point when the meter starts
      @start_time = Time.new(2014, 2, 1, 11, 0, 0)
      Time.stub(:now).and_return(@start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "charges $2.50 for the first 1/6 mile (recorded in cents)" do
      @meter.miles_driven = 0.1
      expect(@meter.amount_due).to eq(250)
    end

    it "charges $2.50 for the first 1/6 mile (recorded in cents)" do
      @meter.miles_driven = 0.0
      expect(@meter.amount_due).to eq(250)
    end

    it "charges $4.50 for the first mile (recorded in cents)" do
      @meter.miles_driven = 1
      expect(@meter.amount_due).to eq(450)
    end

    it "charges $16.10 for a 5.7 mile trip with no time" do
      @meter.miles_driven = 5.7
      expect(@meter.amount_due).to eq(1610)
    end

    it "charges $31.50 for 1 hour wait time, no distance" do
      Time.stub(:now).and_return(@meter.start_time + 60 * 60)
      expect(@meter.amount_due).to eq(3150)
    end

    it "charges $10.23 for 15.5 min wait time, no distance" do
      Time.stub(:now).and_return(@meter.start_time + 15.5 * 60)
      expect(@meter.amount_due).to eq(1023)
    end

    it "charges $23.83 for a 16 min wait time, 5.7 mile trip" do
      Time.stub(:now).and_return(@meter.start_time + 16 * 60)
      @meter.miles_driven = 5.7
      expect(@meter.amount_due).to eq(2383)
    end


  end

  context "Checking amount due after stop_time has been set" do
    before do

      @meter = TaxiMeter.new
      @meter.start

      # We want to freeze time to the point when the meter starts
      @meter.start_time = Time.new(2014, 2, 1, 11, 0, 0)
      @meter.stop_time = Time.new(2014, 2, 1, 12, 0, 0)
      Time.stub(:now).and_return(@meter.start_time + 70*60) #Sets current time past stop time

    end

    it "Charges $31.50 for a 1 hour wait time, no distance" do
      expect(@meter.amount_due).to eq(3150)
    end


  end

  context "Drunk tax is in effect late night" do
    before do
      @start_time = Time.new(2014, 2, 1, 23, 0, 0)
      Time.stub(:now).and_return(@start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "charges $11.23 for a 16 min wait time, no distance" do
      Time.stub(:now).and_return(@meter.start_time + 16 * 60)
      expect(@meter.amount_due).to eq(1123)
    end

    it "charges $24.83 for a 16 min wait time, 5.7 mile trip" do
      Time.stub(:now).and_return(@meter.start_time + 16 * 60)
      @meter.miles_driven = 5.7
      expect(@meter.amount_due).to eq(2483)
    end

  end

  context "Drunk tax is in effect early morning" do
      before do
      @start_time = Time.new(2014, 2, 1, 3, 59, 0)
      Time.stub(:now).and_return(@start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "charges $11.23 for a 16 min wait time, no distance" do
      Time.stub(:now).and_return(@meter.start_time + 16 * 60)
      expect(@meter.amount_due).to eq(1123)
    end

    it "charges $24.83 for a 16 min wait time, 5.7 mile trip" do
      Time.stub(:now).and_return(@meter.start_time + 16 * 60)
      @meter.miles_driven = 5.7
      expect(@meter.amount_due).to eq(2483)
    end
  end

  context "The taxi meter starts from ABIA" do
    before do
      # We want to freeze time to the point when the meter starts
      start_time = Time.new(2014, 2, 1, 11, 0, 0)
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new(airport: true)
      @meter.start
    end

    it "has a minimum fare of $13.10, usually 7.73" do
      Time.stub(:now).and_return(@meter.start_time + 16 * 60)
      expect(@meter.amount_due).to eq(1310)
    end

    it "over the 13.10 minimum, should be 23.83" do
      Time.stub(:now).and_return(@meter.start_time + 16 * 60)
      @meter.miles_driven = 5.7
      expect(@meter.amount_due).to eq(2383)
    end
  end

  it "Makes sure that you can't stop time that hasn't been started" do
    @meter = TaxiMeter.new
    @meter.stop

    expect(@meter.stop_time).to be_nil
  end

end
