require './taxi_meter.rb'


describe TaxiMeter do

  def one_sixth
    1.0 / 6.0
  end

  describe "Basic functionality" do

    before do
      @meter = TaxiMeter.new
    end

    xit "starts at zero" do
      @meter.amount_due = 0
      @meter.miles_driven = 0

      expect(@meter.amount_due).to eq(0)
      expect(@meter.miles_driven).to eq(0)
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
      start_time = Time.now
      Time.stub(:now).and_return(start_time)

      # This should grab the current time
      @meter.start

      # Re-stub Time to be 5 minutes into the future
      stop_time = Time.stub(:now).and_return(start_time + 5 * 60)

      # Once stopped, stop_time shouldn't rely on current time 
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
    it "charges $2.40 for each additional mile, prorated by each 1/6" do
      @meter.miles_driven = one_sixth * 2
      expect(@meter.amount_due).to eq(290)
      
      @meter.miles_driven = 10 + one_sixth
      expect(@meter.amount_due).to eq(2650)
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

     it "Charges $29 for a 5 min wait time with no distance" do
      @meter.miles_driven = 0

      expect(@meter.amount_due).to eq(2900)
    end
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

    xit "has a minimum fare of $13.10"
  end

end
