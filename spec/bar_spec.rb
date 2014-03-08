require 'pry-debugger'
require "./bar.rb"


describe Bar do

  before do
    @bar = Bar.new "The Irish Yodel"
    @well_drink = Item.new("Popov",3)
    @fancy_drink = Item.new("Macallan",15,true)
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

  describe '#happy_hour' do
    it "knows when it is happy hour (3:00pm to 4:00pm)" do
      Time.stub(:now).and_return(Time.parse("15:30"))
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      Time.stub(:now).and_return(Time.parse("17:30"))
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do
    # TODO: WRITE TESTS TO ENSURE BAR KNOWS NOT TO DISCOUNT
    it "does not discount during regular hours" do
      Time.stub(:now).and_return(Time.parse("12:45"))
      @bar.happy_discount = 7
      expect(@bar.happy_discount).to eq(0)
    end
  end

  context "During happy hours" do
    # TODO: WRITE TESTS TO ENSURE BAR DISCOUNTS DURING HAPPY HOUR
    it "discounts during happy hour" do
      Time.stub(:now).and_return(Time.parse("15:36"))
      @bar.happy_discount = 7
      expect(@bar.happy_discount).to eq(1)
    end
  end

  describe "Extension 1: 50% discount M W, 25% other days." do
    it "Discounts 25% on Friday" do
      Time.stub(:now).and_return(Time.new(2014,3,7,15,45)) #Friday
      @bar.happy_discount = 0.25
      expect(@bar.happy_discount).to eq(0.25)
      Time.stub(:now).and_return(Time.new(2014,3,5,15,45)) #Wednesday
      expect(@bar.happy_discount).to eq(0.5)
    end
  end

  describe "Extension 2: Does not discount 'top shelf' drinks" do
    it "Discounts non-top_shelf drink correctly" do
      @bar.happy_discount = 0.5
      Time.stub(:now).and_return(Time.parse("15:36"))
      expect(@bar.current_cost(@well_drink)).to eq(1.5)
    end

    it "Does not discount top_shelf drink" do
      @bar.happy_discount = 0.5
      Time.stub(:now).and_return(Time.parse("15:36"))
      expect(@bar.current_cost(@fancy_drink)).to eq(15)
    end
  end

  describe "Extension 3: Tracks drink purchases and can determine most popular drink" do
    it "Can access number of purchases of each drink" do
      @well_drink = Item.new("Popov",3)
      4.times{ @bar.buy(@well_drink) }
      expect(@bar.times_purchased(@well_drink)).to eq(4)
    end

    xit "Returns most popular drink" do
      3.times{ @bar.buy(@well_drink) }
      6.times{ @bar.buy(@fancy_drink) }
      expect(@bar.most_popular).to eq(@fancy_drink)
    end
  end
end
