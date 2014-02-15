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
      @amount_due = 0
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
    # We want to freeze time to the point when the meter starts
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
      @start_time = Time.parse('3 pm')
      Time.stub(:now).and_return(@start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "charges $2.50 for the first 1/6 mile (recorded in cents)" do
      @meter.miles_driven = 1.0/6
      expect(@meter.amount_due).to eq(250)
    end

    it "charges $2.40 per mile, plus the initial 1/6th cost" do
      @meter.miles_driven=1.0+(1.0/6)
      expect(@meter.amount_due).to eq(490)
    end

    it "charges $29.00 an hour prorated by minute" do
      @start_time = Time.now
      Time.stub(:now).and_return(@meter.start_time + 60 * 60)
      expect(@meter.amount_due).to eq(2900)
    end
    it "charges $29.00 an hour prorated by minute- drove 15 min" do
      @start_time = Time.now
      Time.stub(:now).and_return(@meter.start_time + 15 * 60)
      expect(@meter.amount_due).to eq(725)
    end
     it "charges $29.00 an hour prorated by minute-drove 15 min and 2 1/6 miles" do
      @meter.miles_driven=1.0+(1.0/6)
      @start_time = Time.now
      Time.stub(:now).and_return(@meter.start_time + 15 * 60)
      expect(@meter.amount_due).to eq(1215)
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
      @meter.miles_driven=1.0/6
      expect(@meter.amount_due).to eq(1310)
    end
  end

  context "Drunk tax is in effect late night" do
    before do
      @start_time = Time.parse('9 pm')
      Time.stub(:now).and_return(@start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "charges $8.25 for a 15 min wait time, no distance" do
      Time.stub(:now).and_return(@meter.start_time + 15 * 60)
      expect(@meter.amount_due).to eq(825)
    end

    it "charges $24.83 for a 16 min wait time, 5.7 mile trip" do
      Time.stub(:now).and_return(@meter.start_time + 16 * 60)
      @meter.miles_driven = 5.7
      expect(@meter.amount_due).to eq(2483)
    end
  end
  context "Drunk tax is in effect early morning" do
      before do
      @start_time = Time.parse('3 am')
      Time.stub(:now).and_return(@start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "charges $8.73 for a 16 min wait time, no distance" do
      Time.stub(:now).and_return(@meter.start_time + 16 * 60)
      expect(@meter.amount_due).to eq(873)
    end

    it "charges $24.83 for a 16 min wait time, 5.7 mile trip" do
      Time.stub(:now).and_return(@meter.start_time + 16 * 60)
      @meter.miles_driven = 5.7
      expect(@meter.amount_due).to eq(2483)
    end
  end
end
