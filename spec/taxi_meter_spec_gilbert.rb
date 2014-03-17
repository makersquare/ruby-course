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

    it "starts at zero miles driven" do
      expect(@meter.miles_driven).to eq 0
    end

    # it "cannot set amount due" do
    #   expect { @meter.amount = 99 }.to raise_error
    # end

    # it "cannot set start time nor stop time" do
    #   expect { @meter.start_time = Time.now }.to raise_error
    #   expect { @meter.stop_time = Time.now }.to raise_error
    # end

    it "can specify miles driven" do
      @meter.miles_driven = 5
      expect(@meter.miles_driven).to eq 5
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
      start_time = Time.parse('1:00pm')
      Time.stub(:now).and_return(start_time)

      # This should grab the current time
      @meter.start

      # Re-stub Time to be 5 minutes into the future
      Time.stub(:now).and_return(start_time + 5 * 60)

      # Once started, start_time shouldn't rely on the current time
      expect(@meter.start_time).to eq(start_time)
    end

    it "records the time it stopped" do
      # Explicitly set a start time
      start_time = Time.parse('1:00pm')
      Time.stub(:now).and_return(start_time)

      @meter.start

      # Re-stub Time to be 5 minutes into the future
      end_time = start_time + 5 * 60
      Time.stub(:now).and_return(end_time)

      # Stop time should be what we stubbed
      @meter.stop
      expect(@meter.stop_time).to eq(end_time)
    end

    it "doesn't change amount due after it stops" do
      # Explicitly set a start time
      start_time = Time.parse('1:00pm')
      Time.stub(:now).and_return(start_time)
      @meter.start

      # Re-stub Time to be 5 minutes into the future
      end_time = start_time + 5 * 60
      Time.stub(:now).and_return(end_time)
      @meter.stop

      amount_due_at_stop = @meter.amount_due

      # Re-stub Time to be 30 minutes into the future
      Time.stub(:now).and_return(end_time + 30 * 60)

      # The amount due should not increase
      expect(@meter.amount_due).to eq(amount_due_at_stop)
    end
  end

  context "The taxi meter starts during normal hours" do
    before do
      # We want to freeze time to the point when the meter starts
      @start_time = Time.parse('1:00pm')
      Time.stub(:now).and_return(@start_time)

      @meter = TaxiMeter.new
      @meter.start
    end

    it "charges $2.50 for the first 1/6 mile (recorded in cents)" do
      @meter.miles_driven = one_sixth
      expect(@meter.amount_due).to eq 250
    end

    it "assumes the taxi is going to drive an distance greater than zero" do
      expect(@meter.amount_due).to eq 250
    end

    it "charges $2.40 per mile afterwards, prorated by each 1/6 mile" do
      @meter.miles_driven = 1 + one_sixth
      expect(@meter.amount_due).to eq 490

      @meter.miles_driven = 1 + one_sixth + 0.01
      expect(@meter.amount_due).to eq 530

      @meter.miles_driven = 1 + (one_sixth * 2)
      expect(@meter.amount_due).to eq 530

      @meter.miles_driven = 1 + (one_sixth * 3)
      expect(@meter.amount_due).to eq 570
    end

    it "charges $29.00 per hour, prorated by minute" do
      # Test 30 minutes later
      Time.stub(:now).and_return(@start_time + 30 * 60)
      expect(@meter.amount_due).to eq(250 + (2900 / 2))

      # Test 29.5 minutes later
      Time.stub(:now).and_return(@start_time + 30 * 60 - 0.5)
      expect(@meter.amount_due).to eq(250 + (2900 / 2))

      # Test 60 minutes later
      Time.stub(:now).and_return(@start_time + 60 * 60)
      expect(@meter.amount_due).to eq(250 + 2900)

      # Test 19 hours later
      Time.stub(:now).and_return(@start_time + 19 * 60 * 60)
      expect(@meter.amount_due).to eq(250 + (2900 * 19))
    end

    it "charges for both distance and time" do
      # 120 minutes, 2 1/6 miles
      Time.stub(:now).and_return(@start_time + 2 * 60 * 60)
      @meter.miles_driven = 2 + one_sixth
      expect(@meter.amount_due).to eq(250 + 240*2 + 2900*2)

      # 14 minutes, just over 3/6 miles (counted at 4/6 miles)
      Time.stub(:now).and_return(@start_time + 14 * 60)
      @meter.miles_driven = one_sixth * 3 + 0.01
      expect(@meter.amount_due).to eq(250 + 240/2 + 677)
    end
  end


  it "charges an extra $1 between 9pm and 4am" do
    7.times do |n|
      Time.stub(:now).and_return(Time.parse('9:15pm') + n * 60 * 60)
      meter = TaxiMeter.new
      meter.start
      # We wrap our amount in an array to make it easier to debug which hour n is
      expect([n, meter.amount_due]).to eq [n, 350]
    end
  end


  context "The taxi meter starts from ABIA" do
    before do
      # We want to freeze time to the point when the meter starts
      @start_time = Time.parse('1:00pm')
      Time.stub(:now).and_return(@start_time)

      @meter = TaxiMeter.new(airport: true)
      @meter.start
    end

    it "has a minimum fare of $13.10" do
      expect(@meter.amount_due).to eq 1310

      # 2 1/6 miles drives is only 250 + 480
      @meter.miles_driven = 2 + one_sixth
      expect(@meter.amount_due).to eq 1310

      # 10 minutes is only 250 + 290
      @meter.miles_driven = 0
      Time.stub(:now).and_return(@start_time + 10 * 60)
      expect(@meter.amount_due).to eq 1310
    end

    it "charges correctly when the total fare is over $13.10" do
      # 2 2/6 miles and 15 minutes is 250 + 520 + 725 = 1495
      @meter.miles_driven = 2 + (2 * one_sixth)
      Time.stub(:now).and_return(@start_time + 15 * 60)
      expect(@meter.amount_due).to eq 1495
    end
  end


  context "The taxi meter starts from ABIA after 9pm" do
    before do
      # We want to freeze time to the point when the meter starts
      @start_time = Time.parse('10:00pm')
      Time.stub(:now).and_return(@start_time)

      @meter = TaxiMeter.new(airport: true)
      @meter.start
    end

    it "has a minimum fare of $13.10" do
      expect(@meter.amount_due).to eq 1310

      # 10 minutes is only 100 + 250 + 290
      @meter.miles_driven = 0
      Time.stub(:now).and_return(@start_time + 10 * 60)
      expect(@meter.amount_due).to eq 1310
    end

    it "charges correctly when the total fare is over $13.10" do
      # 1 1/6 miles and 15 minutes is 250 + 240 + 725 + 100 = 1410
      @meter.miles_driven = 1 + one_sixth
      Time.stub(:now).and_return(@start_time + 15 * 60)
      expect(@meter.amount_due).to eq 1315
    end
  end

end
