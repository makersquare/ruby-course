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

  xit "only returns a discount when it's happy hour" do
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

  xit "constrains its happy hour discount to between zero and one" do
    # HINT: You need to write your own setter
    @bar.happy_discount = 2
    expect(@bar.happy_discount).to eq 1

    @bar.happy_discount = -3
    expect(@bar.happy_discount).to eq 0
  end

# # # # # # # # # # # # # # # # # # # # # #
  # DO NOT CHANGE SPECS ABOVE THIS LINE #
# # # # # # # # # # # # # # # # # # # # # #

# , :pending => true
  describe '#happy_hour' do
    it "knows when it is happy hour (3:00pm to 4:00pm)" do
      # TODO: CONTROL TIME
      Time.stub(:now).and_return(Time.parse("3 pm"))
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      # TODO: CONTROL TIME
      Time.stub(:now).and_return(Time.parse("7 pm"))
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do
    # TODO: WRITE TESTS TO ENSURE BAR KNOWS NOT TO DISCOUNT
    it "does not discount during normal hours" do
      Time.stub(:now).and_return(Time.parse("7 pm"))
      expect(@bar.happy_discount).to eq(0)
    end
  end

  context "During happy hours" do
    # TODO: WRITE TESTS TO ENSURE BAR DISCOUNTS DURING HAPPY HOUR
    it "applies the discount during happy hour" do
      Time.stub(:now).and_return(Time.parse("7 pm"))
      expect(@bar.happy_discount).to eq(0)
    end
  end

  it "initializes with empty array of special undiscounted drinks" do
    expect(@bar.exempt_drinks.count).to eq(0)
  end

  it "keeps track of discount-exempt drinks" do
    mojito = Item.new("Mojito", 5.45)
    @bar.add_exempt(mojito)
    expect(@bar.exempt_drinks.count).to eq(1)
   end

   it "initializes an empty hash tracking drink popularity with values set to zero" do
      expect(@bar.pop_drinks.count).to eq(0)
   end

   it "keeps track of drink popularity during and outside of happy hour" do
    mojito = Item.new("Mojito", 5.45)
    added = @bar.drink_graph(mojito)
    expect(added[mojito.name]).to eq(1)
    Time.stub(:now).and_return(Time.parse("3 pm"))
    added = @bar.drink_graph(mojito)
    expect(added[mojito.name]).to eq(1)
   end

end
