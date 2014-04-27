# require 'pry-debugger'
require "./bar.rb"
require 'time'

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
    # @bar.add_menu_item('Cosmo', 5.40)
    item1 = MenuItem.new('Cosmo', 5.40)
    @bar.add_menu_item(item1)
    item2 = MenuItem.new('Salty Dog', 7.80)
    @bar.add_menu_item(item2)
    # @bar.add_menu_item('Salty Dog', 7.80)

    expect(@bar.menu_items.count).to eq(2)
  end

  it "can retrieve menu items" do
    item1 = MenuItem.new('Cosmo', 5.40)
    @bar.add_menu_item(item1)

    expect(@bar.menu_items.first.name).to eq 'Cosmo'
    expect(@bar.menu_items.first.price).to eq 5.40
  end

  it "has a default happy hour discount of zero" do
    expect(@bar.happy_discount).to eq 0
  end

  it "can set its happy hour discount" do
    expect { @bar.happy_discount = 0.5 }.to_not raise_error
  end

  it "only returns a full discount when it's happy hour monday or wednesday" do
    @bar.happy_discount = 0.5
    # allow(Time.now).to receive(:wday).and_return(Time.parse("2014-04-21").wday)
    # allow(Time.now).to receive(:wday).and_return(1)
    allow(Time).to receive(:now).and_return(Date.parse("Monday"))
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

  it "only returns a half discount when it's happy hour rest of week" do
    @bar.happy_discount = 0.5
    allow(Time).to receive(:now).and_return(Date.parse("saturday"))
    
    # HINT: You need to write your own getter

    # We are STUBBING `happy_hour?` to return a specified value.
    # Because of this, you don't have to write a happy_hour? method (yet)
    expect(@bar).to receive(:happy_hour?).and_return(false)
    expect(@bar.happy_discount).to eq 0

    expect(@bar).to receive(:happy_hour?).and_return(true)
    expect(@bar.happy_discount).to eq 0.25

    # Take 2
    @bar.happy_discount = 0.3
    expect(@bar).to receive(:happy_hour?).and_return(false)
    expect(@bar.happy_discount).to eq 0

    expect(@bar).to receive(:happy_hour?).and_return(true)
    expect(@bar.happy_discount).to eq 0.15
  end

  xit "constrains its happy hour discount to between zero and one" do
    expect(@bar).to receive(:happy_hour?).twice.and_return(true)

    # HINT: You need to write your own setter
    @bar.happy_discount = 2
    expect(@bar.happy_discount).to eq 1

    @bar.happy_discount = -3
    expect(@bar.happy_discount).to eq 0
  end

  it "can order drinks" do
    item1 = MenuItem.new('Cosmo', 5.40)
    @bar.add_menu_item(item1)
    item2 = MenuItem.new('Salty Dog', 7.80)
    @bar.add_menu_item(item2)

    @bar.order_drink(item1)
    expect(@bar.drink_orders.size).to eq 1
    expect(@bar.drink_orders.first[0]).to eq item1
  end

  it "tracks number of drink orders" do 
    item1 = MenuItem.new('Cosmo', 5.40)
    @bar.add_menu_item(item1)
    item2 = MenuItem.new('Salty Dog', 7.80)
    @bar.add_menu_item(item2)

    3.times { @bar.order_drink(item1) }
    5.times { @bar.order_drink(item2) }
    expect(@bar.drink_orders.size).to eq 2
    expect(@bar.drink_orders[item1]).to eq 3
    expect(@bar.drink_orders[item2]).to eq 5
  end


# # # # # # # # # # # # # # # # # # # # # #
  # DO NOT CHANGE SPECS ABOVE THIS LINE #
# # # # # # # # # # # # # # # # # # # # # #

describe '#happy_hour?' do
  it "knows when it is happy hour (3:00pm to 4:00pm)" do
    allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
      # TODO: CONTROL TIME
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      allow(Time).to receive(:now).and_return(Time.parse("2:30pm"))
      # TODO: CONTROL TIME
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do
    # TODO: WRITE TESTS TO ENSURE BAR KNOWS NOT TO DISCOUNT
  end

  context "During happy hours" do
    # TODO: WRITE TESTS TO ENSURE BAR DISCOUNTS DURING HAPPY HOUR
  end
end
