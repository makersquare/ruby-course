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

  # Changed this test after completing initial assignment - For extensions the happy_discount is initializd to 0.75 and is only accessible when it is happy hour
  it "has a default happy hour discount of 0.25" do
    expect(@bar).to receive(:happy_hour?).and_return(true)
    expect(@bar.happy_discount).to eq 0.75
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
      allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      allow(Time).to receive(:now).and_return(Time.parse("4:30pm"))
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  it "During normal hours" do
    expect(@bar).to receive(:happy_hour?).and_return(false)
    @bar.add_menu_item('Cosmo', 5.40)
    expect(@bar.buy_drink('Cosmo')).to eq 5.40
  end

  it "During happy hours on slow days" do
    allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
    allow(Date).to receive(:today).and_return(Date.parse("2014-04-21"))
    @bar.add_menu_item('Cosmo', 5.40)
    expect(@bar.buy_drink('Cosmo')).to eq (5.40*0.5)
  end

  it "During happy hours on busy days" do
    allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
    allow(Date).to receive(:wday).and_return(1)
    @bar.add_menu_item('Cosmo', 5.40)
    expect(@bar.buy_drink('Cosmo')).to eq (5.40*0.75)
  end

  it "Allows drinks to be exempt from happy hour discounts" do
    @bar.add_menu_item('Cosmo', 5.40, true)
    allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))

    expect(@bar.buy_drink('Cosmo')).to eq 5.40
  end
end
