require './taxi_meter.rb'
require 'pry-debugger'

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

      # This should grab the current time
      @meter.start

      # Re-stub Time to be 5 minutes into the future
      Time.stub(:now).and_return(start_time + 5 * 60)
      @meter.stop

      expect(@meter.stop_time).to eq(start_time + 5 * 60)

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
      @meter.miles_driven = 1.0 / 6.0


      expect(@meter.amount_due).to eq(250)
    end

    it "charges $2.40 for each additional mile, prorated by 1/6 of a mile" do
      @meter.miles_driven = 2.0 / 6.0

      expect(@meter.amount_due).to eq(290)
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
      @meter.miles_driven = 4


      expect(@meter.amount_due).to eq(1310)
    end
  end

  context "The taxi meter adds charges for time" do
    before do

      @meter = TaxiMeter.new
      start_time = Time.parse("Feb 24 2013 3 PM")
      Time.stub(:now).and_return(start_time)
      @meter.start
      new_time = start_time + (60 * 60)
      Time.stub(:now).and_return(new_time)

    end

    it "adds $29.00 an hour, prorated in minutes to wait times" do
      @meter.miles_driven = 0 # $2.50 regardless
      @meter.stop
      expect(@meter.amount_due).to eq(3150)
    end
  end

  context "The taxi meter starts between 9pm and 4am" do
    before do
      # We want to freeze time to between 9am and 4pm
      start_time = Time.parse("Feb 24 2013 3 AM")
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "adds $1.00 if the time is between 9pm and 4am" do
      @meter.miles_driven = 2.0 / 6
      @meter.stop
      expect(@meter.amount_due).to eq(390)
    end
  end

  context "The taxi meter stops running after the stop time" do

    it "doesn't add more time after the meter stops running" do
      start_time = Time.parse("Feb 24 2013 3 PM")
      Time.stub(:now).and_return(start_time)

      @meter = TaxiMeter.new
      @meter.start
      stop_time = Time.parse("Feb 24 2013 4 PM")
      Time.stub(:now).and_return(stop_time)
      @meter.miles_driven = 4
      @meter.stop
      time_later = Time.parse("Feb 24 2013 5 PM")
      Time.stub(:now).and_return(time_later)

      expect(@meter.amount_due).to eq(4170)

    end
  end

end

# require './taxi_meter.rb'
# require 'pry-debugger'

# describe TaxiMeter do

#   def one_sixth
#     1.0 / 6.0
#   end

#   describe "Basic functionality" do

#     before do
#       @meter = TaxiMeter.new
#     end

#     it "starts at zero" do
#       @meter.amount_due = 0
#       @meter.miles_driven = 0
#     end

#     it "can start and stop" do
#       @meter.start
#       expect(@meter.start_time).to_not be_nil
#       expect(@meter.stop_time).to be_nil

#       @meter.stop
#       expect(@meter.stop_time).to_not be_nil
#     end

#     it "records the time it started" do
#       # We want to freeze time to the point when the meter starts
#       start_time = Time.now
#       Time.stub(:now).and_return(start_time)

#       # This should grab the current time
#       @meter.start

#       # Re-stub Time to be 5 minutes into the future
#       Time.stub(:now).and_return(start_time + 5 * 60)

#       # Once started, start_time shouldn't rely on the current time
#       expect(@meter.start_time).to eq(start_time)
#     end

#     it "records the time it stopped" do
#       # We want to freeze time to the point when the meter starts
#       stop_time = Time.now
#       Time.stub(:now).and_return(stop_time)

#       # This should grab the current time
#       @meter.stop

#       # Re-stub Time to be 5 minutes into the future
#       Time.stub(:now).and_return(stop_time + 5 * 60)

#       # Once started, start_time shouldn't rely on the current time
#       expect(@meter.stop_time).to eq(stop_time)
#     end


#   end

#   context "The taxi meter starts at 8 am" do
#     before do
#       # We want to freeze time to the point when the meter starts
#       start_time = Time.parse("Feb 11 2013 8 AM")
#       Time.stub(:now).and_return(start_time)

#       @meter = TaxiMeter.new
#       @meter.start
#     end

#     it "charges $2.50 for the first 1/6 mile" do
#       @meter.miles_driven = 0.1
#       expect(@meter.amount_due).to eq(250)
#     end

#     it "charges $4.50 for the first mile" do
#       @meter.miles_driven = 1
#       expect(@meter.amount_due).to eq(450)
#     end

#     it "charges $16.10 for a 5.7 mile trip with no time" do
#       @meter.miles_driven = 5.7
#       expect(@meter.amount_due).to eq(1610)
#     end

#     it "charges $29.00 for 1 hour wait time, no distance" do
#       Time.stub(:now).and_return(@meter.start_time + 60 * 60)
#       expect(@meter.amount_due).to eq(2900)
#     end

#     it "charges $7.73 for 15.5 min wait time, no distance" do
#       Time.stub(:now).and_return(@meter.start_time + 15.5 * 60)
#       expect(@meter.amount_due).to eq(773)
#     end

#     it "charges $23.83 for a 16 min wait time, 5.7 mile trip" do
#       Time.stub(:now).and_return(@meter.start_time + 16 * 60)
#       @meter.miles_driven = 5.7
#       expect(@meter.amount_due).to eq(2383)
#     end


#   end

#   context "Checking amount due after stop_time has been set" do
#     before do

#       @meter = TaxiMeter.new
#       start_time = Time.parse("Feb 11 2014 7 AM")
#       Time.stub(:now).and_return(start_time)
#       @meter.start

#       # We want to freeze time to the point when the meter starts

#       stop_time = Time.parse("Feb 11 2014 8 AM")
#       Time.stub(:now).and_return(stop_time) #Sets current time past stop time

#     end

#     it "Charges $29 for a 1 hour wait time, no distance" do
#       expect(@meter.amount_due).to eq(2900)
#     end


#   end

#   context "Drunk tax is in effect late night" do
#     before do
#       start_time = Time.parse("Feb 11 2013 3 AM")
#       Time.stub(:now).and_return(start_time)

#       @meter = TaxiMeter.new
#       @meter.start
#     end

#     it "charges $8.73 for a 16 min wait time, no distance" do
#       Time.stub(:now).and_return(@meter.start_time + 16 * 60)
#       expect(@meter.amount_due).to eq(873)
#     end

#     it "charges $24.83 for a 16 min wait time, 5.7 mile trip" do
#       Time.stub(:now).and_return(@meter.start_time + 16 * 60)
#       @meter.miles_driven = 5.7
#       expect(@meter.amount_due).to eq(2483)
#     end

#   end

#   context "Drunk tax is in effect early morning" do
#       before do
#       @start_time = Time.new(2014, 2, 1, 3, 59, 0)
#       Time.stub(:now).and_return(@start_time)

#       @meter = TaxiMeter.new
#       @meter.start
#     end

#     it "charges $8.73 for a 16 min wait time, no distance" do
#       Time.stub(:now).and_return(@meter.start_time + 16 * 60)
#       expect(@meter.amount_due).to eq(873)
#     end

#     it "charges $24.83 for a 16 min wait time, 5.7 mile trip" do
#       Time.stub(:now).and_return(@meter.start_time + 16 * 60)
#       @meter.miles_driven = 5.7
#       expect(@meter.amount_due).to eq(2483)
#     end
#   end

#   context "The taxi meter starts from ABIA" do
#     before do
#       # We want to freeze time to the point when the meter starts
#       start_time = Time.parse("Feb 11 2013 2014 8 AM")
#       Time.stub(:now).and_return(start_time)

#       @meter = TaxiMeter.new(airport: true)
#       @meter.start
#     end

#     it "has a minimum fare of $13.10, usually 7.73" do
#       Time.stub(:now).and_return(@meter.start_time + 16 * 60)
#       expect(@meter.amount_due).to eq(1310)
#     end

#     it "over the 13.10 minimum, should be 23.83" do
#       Time.stub(:now).and_return(@meter.start_time + 16 * 60)
#       @meter.miles_driven = 5.7
#       expect(@meter.amount_due).to eq(2383)
#     end
#   end

#   context "The taxi meter will not give an amount due if the meter has not been started" do
#     it "won't give an amount due if meter has not started" do
#       @meter = TaxiMeter.new

#       expect(@meter.amount_due).to eq(0)
#     end
#   end

# end
