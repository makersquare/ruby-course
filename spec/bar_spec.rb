
require "./bar.rb"


describe Bar do

  before do
    @bar = Bar.new name: "The Irish Yodel"
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
    allow(@bar).to receive(:happy_hour?).and_return(false)
    expect(@bar.happy_discount).to eq 0

    allow(@bar).to receive(:happy_hour?).and_return(true)
    expect(@bar.happy_discount).to eq 0.5

    # Take 2
    @bar.happy_discount = 0.3
    allow(@bar).to receive(:happy_hour?).and_return(false)
    expect(@bar.happy_discount).to eq 0

    allow(@bar).to receive(:happy_hour?).and_return(true)
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
      happy_hour = Time.parse('3:30 pm')
      Time.stub(:now).and_return(happy_hour)
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      not_happy_hour = Time.parse('5:00 pm')
      Time.stub(:now).and_return(not_happy_hour)
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do
    before do
      @bar = Bar.new name: "The Irish Yodel"
      @normal_hour = Time.parse('5:00 pm')
      Time.stub(:now).and_return(@normal_hour)
    end
    # TODO: WRITE TESTS TO ENSURE BAR KNOWS NOT TO DISCOUNT
    it "should return normal price for an item" do
      @bar.add_menu_item('martini', 12)
      @bar.happy_discount = 0.5
      expect(@bar.menu_items.first.price).to eq 12
    end

    it "should not be happy hour" do
      expect(@bar.happy_hour?).to be_false
    end
  end

  context "During happy hours" do
    # TODO: WRITE TESTS TO ENSURE BAR DISCOUNTS DURING HAPPY HOUR
    before do
      @bar = Bar.new name: "The Irish Yodel"
      @happy_hour = Time.parse('3:35 pm')
      Time.stub(:now).and_return(@happy_hour)
    end

    it"should return discounted price for an item" do
      @bar.add_menu_item('martini', 12)
      @bar.happy_discount = 0.5
      expect(@bar.show_menu.first.price).to eq 6.0
    end

    it "should be happy hour" do
      expect(@bar.happy_hour?).to be_true
    end
  end
end
