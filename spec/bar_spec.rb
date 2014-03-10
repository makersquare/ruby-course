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
    expect(@bar.happy_discount(Item.new("tequila",2,true))).to eq 0
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
    expect(@bar.happy_discount(Item.new("tequila",2,true))).to eq 0

    expect(@bar).to receive(:happy_hour?).and_return(true)
    expect(@bar.happy_discount(Item.new("tequila",2,true))).to eq 0.5

    # Take 2
    @bar.happy_discount = 0.3
    expect(@bar).to receive(:happy_hour?).and_return(false)
    expect(@bar.happy_discount(Item.new("tequila",2,true))).to eq 0

    expect(@bar).to receive(:happy_hour?).and_return(true)
    expect(@bar.happy_discount(Item.new("tequila",2,true))).to eq 0.3
  end

  it "constrains its happy hour discount to between zero and one" do
    expect(@bar).to receive(:happy_hour?).twice.and_return(true)

    # HINT: You need to write your own setter
    @bar.happy_discount = 2
    expect(@bar.happy_discount(Item.new("tequila",2,true))).to eq 1

    @bar.happy_discount = -3
    expect(@bar.happy_discount(Item.new("tequila",2,true))).to eq 0
  end

# # # # # # # # # # # # # # # # # # # # # #
  # DO NOT CHANGE SPECS ABOVE THIS LINE #
# # # # # # # # # # # # # # # # # # # # # #

  describe '#happy_hour'  do
    it "knows when it is happy hour (3:00pm to 4:00pm)" do
      # TODO: CONTROL TIME
       current_time = Time.parse('3 pm')
      Time.stub(:now).and_return(current_time)

      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      # TODO: CONTROL TIME
      current_time = Time.parse('5 pm')
      Time.stub(:now).and_return(current_time)
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  it "knows not to discount during normal hours" do
    # TODO: WRITE TESTS TO ENSURE BAR KNOWS NOT TO DISCOUNT
    current_time = Time.parse ('1 pm')
    Time.stub(:now).and_return(current_time)

    expect(@bar.happy_hour?).to eq(false)
    expect(@bar.happy_discount(Item.new("tequila",2,true))).to eq (0)

  end

  it "knows to discount during happy hours" do
    # TODO: WRITE TESTS TO ENSURE BAR DISCOUNTS DURING HAPPY HOUR
    current_time = Time.parse('3 pm')
    Time.stub(:now).and_return(current_time)
    @bar.happy_discount = 1
    expect(@bar.happy_hour?).to eq(true)
    expect(@bar.happy_discount(Item.new("tequila",2,true))).to eq (1)
  end

  it "applies .50 discount on Wednesdays and Mondays only" do
    current_time = Time.parse('3 pm')
    expect(@bar).to receive(:slowday?).and_return(true)
    expect(@bar).to receive(:happy_hour?).and_return(true)
    @bar.happy_discount = 0.5
    expect(@bar.happy_discount(Item.new("tequila",2,true,true))).to eq(0.5)
end

  it "determines whether a drink is eligible for discount" do
    drink = Item.new("tequila", 2, true)
    current_time = Time.parse('3 pm')
    Time.stub(:now).and_return(current_time)
    @bar.happy_discount = 1
    expect(@bar.happy_hour?).to eq(true)
    expect(@bar.happy_drink?(drink)).to eq(true)
    expect(@bar.happy_discount(drink)).to eq(1)
    end

  it "records drink purchase and keeps track of most popular drinks" do
  tequila = Item.new("tequila",2,true)
  jose = Item.new("tequila",2,true)
  gin = Item.new("gin",2,true)
  @bar.purchase_drink(tequila)
  @bar.purchase_drink(gin)
  @bar.purchase_drink(jose)
  expect(@bar.most_popular).to eq(["tequila", "gin"])
end

it "records drink purchases during happy hour" do
  current_time = Time.parse("3 pm")
  Time.stub(:now).and_return(current_time)
  expect(@bar.happy_hour?).to eq(true)
  @bar.purchase_drink(Item.new("tequila",2, true))
  expect(@bar.happy_purchase).to eq(1)
end

it "keeps track of most popular happy hour and normal purchases" do
  jose = Item.new("tequila",2,true)
  gin = Item.new("gin",2,true)
  tequila = Item.new("tequila",2,true)
  current_time = Time.parse('3 pm')
  Time.stub(:now).and_return(current_time)
  @bar.purchase_drink(tequila)
  @bar.purchase_drink(gin)
  @bar.purchase_drink(jose)
  expect(@bar.most_popular_happy).to eq(["tequila","gin"])
end

it "gives different discounts to unique items" do
  jose = Item.new("tequila",2,true,true)
  @bar.unique?(jose)
  current_time = Time.parse('3 pm')
  Time.stub(:now).and_return(current_time)
  expect(@bar.happy_discount(jose)).to eq(0.7)
  end
end