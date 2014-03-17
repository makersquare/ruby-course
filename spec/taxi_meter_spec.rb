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
    # We want to freeze time to the point when the meter starts
      start_time = Time.now
      Time.stub(:now).and_return(start_time)

    # This should grab the current time
      @meter.start

    # Stub the stop time
      stop_time = Time.now
      Time.stub(:now).and_return(stop_time)

      @meter.stop

      expect(@meter.stop_time).to eq(stop_time)
    end

    it "records the passage of time between start and stop" do
      # Freeze time to the point when the meter starts
      start_time = Time.now
      Time.stub(:now).and_return(start_time)

      # This should grab the current time
      @meter.start

      # Re-stub Time to be 5 minutes into the future
      Time.stub(:now).and_return(start_time + 5 * 60)

      # Stop should grab the later time
      @meter.stop

      # Test stop time
      expect(@meter.stop_time - @meter.start_time).to eq(300)
    end

    it "can't be stopped if the meter hasn't started yet" do
      @meter.stop
      expect(@meter.stop_time).to be_nil
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

    it "charges for the first 1/6 mile as soon as the meter is turned on" do
      @meter.miles_driven = 0
      expect(@meter.amount_due).to eq(250)
    end
  end


  context "The taxi meter starts from ABIA" do
    before do
      # We want to stub time to early in the day
      start_time = Time.parse('11 am')
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new(airport: true)
      @meter.start
    end

    it "has a minimum fare of $13.10 (recorded in cents)" do
      expect(@meter.amount_due).to eq(1310)
    end
  end

  context "The taxi meter charges more for different start times" do

    it "charges an additional $1.00 (recorded in cents) between 9 pm and 4 am" do
      # Set time to 11 pm when the meter starts
      start_time = Time.parse('11 pm')
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
      @meter.miles_driven = one_sixth
      expect(@meter.amount_due).to eq(350)
    end

    it "does not charge an additional $1.00 (recorded in cents) at other times" do
      # Set time to 4 pm when the meter starts
      start_time = Time.parse('4 pm')
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
      @meter.miles_driven = one_sixth
      expect(@meter.amount_due).to eq(250)
    end
  end

  context "It charges $2.50 for the first 1/6 mile and $2.40 for each additional mile" do
    before do
      # Set time to 1 pm when the meter starts
      start_time = Time.parse('1 pm')
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "charges $2.50 for the first 1/6 mile (recorded in cents)" do
      @meter.miles_driven = one_sixth
      expect(@meter.amount_due).to eq(250)
    end

    it "charges $2.40 for each additional mile (prorated by each 1/6 mile)" do
      @meter.miles_driven = one_sixth * 2
      expect(@meter.amount_due).to eq(290)
    end
  end


  context "The taxi meter charges for wait time" do
    before do
      # Set time to 10 am when the meter starts
      start_time = Time.parse('10 am')
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "charges for 5 minutes of wait time and travelling less than 1/6 mile" do

    # Re-stub Time to be 5 minutes into the future
    Time.stub(:now).and_return(@meter.start_time + 5 * 60)

    expect(@meter.amount_due).to eq(492)
    end

    it "charges for an hour of wait time and travelling 0.2 miles" do

    # Re-stub Time to be 5 minutes into the future
    Time.stub(:now).and_return(@meter.start_time + 60 * 60)
    @meter.miles_driven = 0.2

    expect(@meter.amount_due).to eq(3190)
    end
  end

  context "It charges the correct amount after the meter is stopped" do
    before do
      # Set time to 10 am when the meter starts
      start_time = Time.parse('10 am')
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
      @meter.miles_driven = 3.7
    end

    it "uses the stop time and not the current time" do
    # Set time to 10:10 am when the meter stops
    stop_time = Time.parse('10:10 am')
    Time.stub(:now).and_return(stop_time)
    @meter.stop

    # Set time to 10:15 am when the amount due is called
    test_time = Time.parse('10:15 am')
    Time.stub(:now).and_return(test_time)

    expect(@meter.amount_due).to eq(1613)
    end
  end

end
