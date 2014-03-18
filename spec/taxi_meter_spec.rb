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
      @meter.first_sixth
    end

    it "charges $2.50 for the first 1/6 mile (recorded in cents)" do
      expect(@meter.amount_due).to eq(250)
      expect(@meter.miles_driven).to eq(1.0/6.0)
  end
end

  context "The taxi meter starts from ABIA" do
    before do
      # We want to freeze time to the point when the meter starts
      start_time = Time.now
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new(airport: true)
      @meter.start
      @meter.airport_rate
    end

    it "has a minimum fare of $13.10" do
      expect(@meter.amount_due).to eq(1310)
    end
  end

  context "The taxi meter charges 2.40 per mile" do
    before do
      start_time = Time.now
      Time.stub(:now).and_return(start_time)
      @meter = TaxiMeter.new
      @meter.start
      @meter.add_distance(1)
      @meter.stop
      @meter.calculate_rate
    end
    it "calculates the base rate correctly" do
      expect(@meter.calculate_rate).to eq(5.75)
    end
  end

  context "The taxi meter charges $29 per hour" do
    before do
      start_time = Time.now
      Time.stub(:now).and_return(start_time)
      @meter = TaxiMeter.new
      @meter.start
      Time.stub(:now).and_return(start_time + 3600)
      @meter.stop
    end
    it "calculate the hourly rate correctly" do
      expect(@meter.calculate_rate).to eq(31.9)
    end
  end

  context "The taxi meter charges an additional dollar after 9 pm" do
    before do
      start_time = Time.parse("10 pm")
      Time.stub(:now).and_return(start_time)
      @meter = TaxiMeter.new
      @meter.start
      @meter.late_rate
    end
    it "calculates the late night rate correctly" do
      expect(@meter.amount_due).to eq(100)
    end
  end

end
