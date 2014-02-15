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

      expect(@meter.amount_due).to eq(2.50)
    end

    it "charges $2.40 for each additional mile, prorated by each 1/6 mile" do
      @meter.miles_driven = (2.0 + (3.0/7.0))
      expect(@meter.amount_due).to eq(8.10)
    end

    it "charges an additional $1 if started between 9pm and 4am" do
      Time.stub(:now).and_return(Time.parse('10pm'))
      @meter.miles_driven = 0
      expect(@meter.amount_due).to eq(1)
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
      expect(@meter.amount_due).to eq(29)
    end

    it "charges $14.5 for waiting a half hour" do
      new_time = @start_time + (60*30)
      Time.stub(:now).and_return(new_time)
      expect(@meter.amount_due).to eq(14.5)
    end

    it "charges a prorated amount by the minute" do
      new_time = @start_time + (60*13)
      Time.stub(:now).and_return(new_time)
      expect(@meter.amount_due).to eq(6.28)
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
      expect(@meter.amount_due).to eq(13.10)
    end

    it "adds on to an already started trip" do
      @meter.miles_driven = one_sixth
      expect(@meter.amount_due).to eq(15.60)
    end

  end

end
