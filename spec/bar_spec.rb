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

  # Changed this test after completing initial assignment - For extensions the std_happy_discount is initializd to 0.75 and is only accessible when it is happy hour
  it "has a default happy hour discount of 0.75" do
    expect(@bar).to receive(:happy_hour?).and_return(true)
    expect(@bar.std_happy_discount).to eq 0.75
  end

  it "can set its happy hour discount" do
    expect { @bar.std_happy_discount = 0.5 }.to_not raise_error
  end

  it "only returns a discount when it's happy hour" do
    # Changed this test after completing initial assignment. std_happy_discount is now initialized to 0.75 and changed to 0.5 on slow days.

    # @bar.std_happy_discount = 0.5
    # HINT: You need to write your own getter

    # We are STUBBING `happy_hour?` to return a specified value.
    # Because of this, you don't have to write a happy_hour? method (yet)
    expect(@bar).to receive(:happy_hour?).and_return(false)
    expect(@bar.std_happy_discount).to eq 0

    expect(@bar).to receive(:happy_hour?).and_return(true)
    expect(@bar.std_happy_discount).to eq 0.75

    # Take 2
    @bar.std_happy_discount = 0.3
    expect(@bar).to receive(:happy_hour?).and_return(false)
    expect(@bar.std_happy_discount).to eq 0

    expect(@bar).to receive(:happy_hour?).and_return(true)
    expect(@bar.std_happy_discount).to eq 0.3
  end

  it "can track drink purchases" do
    @bar.add_menu_item('Cosmo',4.5)
    @bar.buy_drink('Cosmo')

    expect(@bar.purchase_list.length).to eq 1
  end

  it "can return the most popular purchase" do
    @bar.add_menu_item('Cosmo',4.5)
    @bar.add_menu_item('Beer',3)
    @bar.buy_drink('Cosmo')
    @bar.buy_drink('Cosmo')
    @bar.buy_drink('Beer')
    expect(@bar.most_popular_drink(@bar.purchase_list)).to eq 'Cosmo'
  end

  it "Tracks most popular drinks in and out of happy hour" do
    @bar.add_menu_item('Cosmo', 5.40, true)
    @bar.add_menu_item('Special Beer', 3.00)
    @bar.buy_drink('Cosmo')
    @bar.buy_drink('Cosmo')
    @bar.buy_drink('Special Beer')

    allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
    @bar.buy_drink('Special Beer')
    @bar.buy_drink('Special Beer')
    @bar.buy_drink('Cosmo')

    #binding.pry
    expect(@bar.most_popular_drink(@bar.reg_purchases)).to eq 'Cosmo'
    expect(@bar.most_popular_drink(@bar.hh_purchases)).to eq 'Special Beer'
  end


  it "constrains its happy hour discount to between zero and one" do
  expect(@bar).to receive(:happy_hour?).twice.and_return(true)

    # HINT: You need to write your own setter
  @bar.std_happy_discount = 2
    expect(@bar.std_happy_discount).to eq 1

    # Changed this test to eq 0.25 since the slow day discount reduces discount by an additional 0.25
  @bar.std_happy_discount = -3
    expect(@bar.std_happy_discount).to eq 0.25
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

    # Happy hour discount should not be applied unless it is happy hour
    expect(@bar.buy_drink('Cosmo')).to eq 5.40
  end

  it "During happy hours on slow days" do
    allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
    allow(Date).to receive(:today).and_return(Date.parse("2014-04-21"))
    @bar.add_menu_item('Cosmo', 5.40)

    # Happy hour discount should be 50% on slow days
    expect(@bar.buy_drink('Cosmo')).to eq (5.40*0.5)
  end

  it "During happy hours on busy days" do
    allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
    allow(Date).to receive(:wday).and_return(1)
    @bar.add_menu_item('Cosmo', 5.40)

    # Happy hour discount should be 25% on busy days
    expect(@bar.buy_drink('Cosmo')).to eq (5.40*0.75)
  end

  it "Allows drinks to be exempt from happy hour discounts" do
    @bar.add_menu_item('Cosmo', 5.40, true)
    allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))

    expect(@bar.buy_drink('Cosmo')).to eq 5.40
  end

  it "Allow items to have special happy hour discounts" do
    allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
    @bar.add_menu_item('Cosmo', 5.40)
    @bar.add_menu_item('Special Beer', 3.00, false, 0.5)
    # Make sure regular happy hour pricing still applies
    expect(@bar.buy_drink('Cosmo')).to eq (5.40*0.75)

    # Make sure special happy hour pricing is applied where necessary
    expect(@bar.buy_drink('Special Beer')).to eq (3.00*0.5)
  end

  it "Tracks how many drinks are purchased during happy hour" do
    allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
    @bar.add_menu_item('Cosmo', 5.40)
    @bar.add_menu_item('Special Beer', 3.00, false, 0.5)
    @bar.buy_drink('Cosmo')
    @bar.buy_drink('Cosmo')
    @bar.buy_drink('Special Beer')
    @bar.buy_drink('Special Beer')

    expect(@bar.hh_purchases.count).to eq 4
  end
end
