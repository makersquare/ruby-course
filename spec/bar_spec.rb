require 'pry-debugger'
require "./bar.rb"


describe Bar do

  before do
    @bar = Bar.new "The Irish Yodel"
  end

  it "initializes with a name" do
    expect(@bar.name).to eq("The Irish Yodel")
  end

  it "cannot change its name" do
    # That would require a lengthy marketing meeting
    expect {
      @bar.name = 'lolcat cave'
    }.to raise_error
  end

  it "initializes with an empty menu" do
    expect(@bar.menu_items.count).to eq(0)
  end

  it "can add menu items" do
    @bar.add_menu_item('Cosmo', 5.40)
    @bar.add_menu_item('Salty Dog', 7.80)

    expect(@bar.menu_items.count).to eq(2)
  end

  it "can retrieve menu items" do
    @bar.add_menu_item('Little Johnny', 9.95)
    item = @bar.menu_items.first
    expect(item.name).to eq 'Little Johnny'
    expect(item.price).to eq 9.95
  end

  it "has a default happy hour discount of zero" do
    expect(@bar.happy_discount).to eq 0
  end

  it "can set its happy hour discount" do
    expect { @bar.happy_discount = 0.5 }.to_not raise_error
  end

  it "only returns a discount when it's happy hour" do
    @bar.happy_discount = 0.5
    # HINT: You need to write your own getter

    # We are STUBBING `happy_hour?` to return a specified value.
    # Because of this, you don't have to write a happy_hour? method (yet)
    expect(@bar).to receive(:happy_hour?).and_return(false)
    expect(@bar.happy_discount).to eq 0

    expect(@bar).to receive(:happy_hour?).and_return(true)
    expect(@bar.happy_discount).to eq 0.5

    # Take 2
    @bar.happy_discount = 0.3
    expect(@bar).to receive(:happy_hour?).and_return(false)
    expect(@bar.happy_discount).to eq 0

    expect(@bar).to receive(:happy_hour?).and_return(true)
    expect(@bar.happy_discount).to eq 0.3
  end

  it "constrains its happy hour discount to between zero and one" do
    expect(@bar).to receive(:happy_hour?).twice.and_return(true)

    # HINT: You need to write your own setter
    @bar.happy_discount = 2
    expect(@bar.happy_discount).to eq 1

    @bar.happy_discount = -3
    expect(@bar.happy_discount).to eq 0
  end

# # # # # # # # # # # # # # # # # # # # # #
  # DO NOT CHANGE SPECS ABOVE THIS LINE #
# # # # # # # # # # # # # # # # # # # # # #

  describe '#happy_hour?' do

    it "knows when it is happy hour (3:00pm to 4:00pm)" do
      Time.stub(:now).and_return(Time.parse("3pm"))
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      Time.stub(:now).and_return(Time.parse("4pm"))
      expect(@bar.happy_hour?).to eq(false)
    end


    it "gives a normal price for item during normal hours" do
        Time.stub(:now).and_return(Time.parse("4pm"))
        bar = Bar.new("bar")
        bar.happy_discount = 0.5
        steak = Item.new("steak", 20)
        blue_moon = Item.new("blue moon", 5)
        expect(bar.get_price(steak)).to eq(20)
        expect(bar.get_price(blue_moon)).to eq(5)
      end

  it "gives a discounted price for items during happy hour" do
       Time.stub(:now).and_return(Time.parse("3pm"))
        bar = Bar.new("bar")
        bar.happy_discount = 0.5
        steak = Item.new("steak", 20)
        blue_moon = Item.new("blue moon", 5)
        expect(bar.get_price(steak)).to eq(10)
        expect(bar.get_price(blue_moon)).to eq(2.50)
      end

  it "gives 0.5 discount on mondays and wednesdays" do
      #test 1
      Time.stub(:now).and_return(Time.parse("2014-03-17 3pm"))
      bar = Bar.new("bar")
      bar.happy_discount = 0.5
      bar.day_checker
      steak = Item.new("steak", 20)
      blue_moon = Item.new("blue moon", 5)
      expect(bar.get_price(steak)).to eq(10)
      expect(bar.get_price(blue_moon)).to eq(2.50)
      #test 2
      Time.stub(:now).and_return(Time.parse("2014-03-19 3pm"))
      bar = Bar.new("bar")
      bar.happy_discount = 0.5
      bar.day_checker
      steak = Item.new("steak", 20)
      blue_moon = Item.new("blue moon", 5)
      expect(bar.get_price(steak)).to eq(10)
      expect(bar.get_price(blue_moon)).to eq(2.50)
  end

  it "gives 0.25 discount on all other days" do
    #test 1
      Time.stub(:now).and_return(Time.parse("2014-03-18 3pm"))
      bar = Bar.new("bar")
      bar.happy_discount = 0.5
      bar.day_checker
      steak = Item.new("steak", 20)
      blue_moon = Item.new("blue moon", 5)
      expect(bar.get_price(steak)).to eq(15)
      expect(bar.get_price(blue_moon)).to eq(3.75)

    #test 2
      Time.stub(:now).and_return(Time.parse("2014-03-20 3pm"))
      bar = Bar.new("bar")
      bar.happy_discount = 0.5
      bar.day_checker
      steak = Item.new("steak", 20)
      blue_moon = Item.new("blue moon", 5)
      expect(bar.get_price(steak)).to eq(15)
      expect(bar.get_price(blue_moon)).to eq(3.75)
  end

  it "allows specific item to either be or not be happy hour discounted" do
      Time.stub(:now).and_return(Time.parse("3pm"))
      bar = Bar.new("bar")
      bar.happy_discount = 0.5
      steak = Item.new("steak", 20, false)
      blue_moon = Item.new("blue moon", 5)
      expect(bar.get_price(steak)).to eq(20)
      expect(bar.get_price(blue_moon)).to eq(2.50)
  end

  it "record of items purchased" do
    bar = Bar.new("bar")
    blue_moon = Item.new("blue moon", 5)
    expect(bar.items_purchased.count).to eq(0)
    bar.item_bought(blue_moon)
    expect(bar.items_purchased.count).to eq(1)
    steak = Item.new("steak", 20)
    expect(bar.items_purchased.count).to eq(1)
    bar.item_bought(steak)
    expect(bar.items_purchased.count).to eq(2)
  end

  it "gives most popular item ordered at bar" do
    bar = Bar.new("bar")
    blue_moon = Item.new("blue moon", 5)
    steak = Item.new("steak", 20)
    bar.item_bought(blue_moon)
    bar.item_bought(steak)
    bar.item_bought(steak)
    expect(bar.most_popular_item).to eq("steak")
  end
end
end














