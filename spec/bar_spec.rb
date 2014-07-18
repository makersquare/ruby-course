require 'pry-byebug'
require "./bar.rb"


describe Bar do

  before do
    @bar = Bar.new("The Irish Yodel")
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

    it "knows when it is not happy hour (3:00pm to 4:00pm)" do
      # TODO: CONTROL TIME
      Time.stub(:now).and_return(Time.parse("2014-01-01 16:00:00"))
      expect(@bar.happy_hour?).to eq(false)
    end

    it "is happy hour otherwise" do
      # TODO: CONTROL TIME
      Time.stub(:now).and_return(Time.parse("2014-01-01 15:00:00"))
      expect(@bar.happy_hour?).to eq(true)
    end

  end

  context "During normal hours" do
    before(:each) do
      @bar = Bar.new("Videology")
      Time.stub(:now).and_return(Time.parse("2014-01-01 16:00:00"))
    end
    # TODO: WRITE TESTS TO ENSURE BAR KNOWS NOT TO DISCOUNT
    it "is not happy hour" do
      @bar.happy_hour?.should be_false
    end

    it "has a discount of 0" do
      @bar.happy_discount.should eq(0)
    end
  end

  context "During happy hours" do
    # TODO: WRITE TESTS TO ENSURE BAR DISCOUNTS DURING HAPPY HOUR
    before(:each) do
      @bar = Bar.new("Videology")
      Time.stub(:now).and_return(Time.parse("2014-07-14 15:00:00"))
      @bar.add_menu_item('G&T', 6)
      @bar.happy_discount = 0.5
    end

    it "is happy_hour" do
      @bar.happy_hour?.should be_true
    end

    it "has a discount of 0.5" do
      @bar.happy_discount.should eq(0.5)
    end

    it "should cost $3 for a G&T if it's Monday or Wednesday" do
      @bar.get_price('G&T').should eq(3.0)
    end

    it "should cost $4.50 for a G&T other days" do
      Time.stub(:now).and_return(Time.parse("2014-07-15 15:00:00"))
      @bar.get_price('G&T').should eq(4.5)
    end

  end
end
