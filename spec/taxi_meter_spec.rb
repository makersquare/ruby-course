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
      sleep(2)
      @meter.stop
      expect(@meter.stop_time).should be_within(0.1).of(start_time+2)
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
      @meter.miles_driven = 1.0/6.0
      expect(@meter.amount_due).to eq(250)
    end

    it "charges $2.40 for every mile after, prorated by each 1/6" do
      @meter.miles_driven = 3.0/6.0
      expect(@meter.amount_due).to eq(250+80)
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

    it "has a fare of 13.10 + the fare for the first mile" do
      @meter.miles_driven = 1.0/6.0
      expect(@meter.amount_due).to eq(1310+250)
    end

    it "has a fare of 13.10 + the fare for the first two miles" do
      #should prorate the second mile
      @meter.miles_driven = 2+(1.0/6.0)
      expect(@meter.amount_due).to eq(1310+250+(240*2))
      #should not prorate over into a third mile
      @meter.miles_driven = 7.0/6.0
      expect(@meter.amount_due).to eq(1310+250+(240*1))
    end
  end
end


