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

    ### CHECK THIS TEST ###
    it "records the time it stopped" do
      stop_time = Time.now
      Time.stub(:now).and_return(stop_time)
      @meter.stop
      Time.stub(:now).and_return(stop_time + 5 + 60)
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

    ### CHECK THIS TEST ###
    it "charges $2.50 for the first 1/6 mile (recorded in cents)" do
      @meter.miles_driven = 0.1
      expect(@meter.amount_due).to eq(250)

      #charges 2.40 per mile prorated for each additional 1/6 mile
      @meter.miles_driven = 1.0
      expect(@meter.amount_due).to eq(450)
      # (2.50+(2.40*(5.0/6.0))).ceil_to(2)
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
      @meter.miles_driven = 1.0
      expect(@meter.amount_due).to eq(1310)
      @meter.miles_driven = 2.0
      expect(@meter.amount_due).to eq(1310)
      @meter.miles_driven = 6.0
      expect(@meter.amount_due).to eq(1650)
    end
  end

  context "The taxi meter starts between 9pm and 4am" do
    before do
      @meter = TaxiMeter.new

      start_time = Time.parse("9:30 pm")
      Time.stub(:now).and_return(start_time)
      @meter.start

      stop_time = Time.parse("10:30 pm")
      Time.stub(:now).and_return(stop_time)
      @meter.stop


    end

    it "charges an additional $1.00 if start between 9pm and 4am" do

      @meter.miles_driven = 0.1
      expect(@meter.amount_due).to eq(3250)

      @meter.miles_driven = 1.0
      expect(@meter.amount_due).to eq(3450)
    end

  end

  context "Checking wait time with no distance" do
    before do

      @meter = TaxiMeter.new

      # We want to freeze time to the point when the meter starts
      start_time = Time.parse("3:00 pm")
      Time.stub(:now).and_return(start_time)
      @meter.start

      stop_time = Time.parse("4:00 pm")
      Time.stub(:now).and_return(stop_time)
      @meter.stop

    end

    it "Charges $29 for a 1 hour wait time, no distance" do
      expect(@meter.amount_due).to eq(2900)
    end
  end

end
