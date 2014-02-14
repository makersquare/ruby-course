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
    @bar.happy_discount = 0.5
    expect(@bar.happy_discount).to eq 0.5
  end

  it "constrains its happy hour discount to between zero and one" do

    @bar.happy_discount = 2
    expect(@bar.happy_discount).to eq 1

    @bar.happy_discount = -3
    expect(@bar.happy_discount).to eq 0
  end

# # # # # # # # # # # # # # # # # # # # # #
  # DO NOT CHANGE SPECS ABOVE THIS LINE #
# # # # # # # # # # # # # # # # # # # # # #

  describe '#happy_hour' do

    before do
      @bar = Bar.new("The Liberty")
    end

    it "knows when it is happy hour (3:00pm to 4:00pm)" do
      @three_pm = Time.parse("2014-02-11 15:00:00 -0600")
      Time.stub(:now).and_return(@three_pm)

      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      @five_pm = Time.parse("2014-02-11 17:00:00 -0600")
      Time.stub(:now).and_return(@five_pm)

      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do

    before do
      @bar = Bar.new("The Liberty")
    end

    it "does not discount drinks during normal hours" do
      @five_pm = Time.parse("2014-02-11 17:00:00 -0600")
      Time.stub(:now).and_return(@five_pm)
      @bar.add_menu_item('Pecan Porter', 5.50)

      expect(@bar.get_price('Pecan Porter')).to eq(5.50)
    end

  end

  context "During happy hours" do

    before do
      @bar = Bar.new("The Liberty")
      @bar.add_menu_item('Pecan Porter', 5.50)
    end

    it "discounts drinks during happy hours" do
      @three_pm = Time.parse("2014-02-11 15:00:00 -0600")
      Time.stub(:now).and_return(@three_pm)

      expect(@bar.get_price('Pecan Porter')).to eq(2.75)
    end

    it "discounts 25% on Mondays and Wednesdays" do
      @monday = Time.parse("2014-02-10 15:00:00 -0600")
      Time.stub(:now).and_return(@monday)

      expect(@bar.get_price('Pecan Porter')).to eq(4.125)
    end

  end

  describe Item do

    it "specifies drinks that are exempt from discount" do
      @bar = Bar.new("The Liberty")
      @bar.add_menu_item('Pecan Porter', 5.50, exempt: true)

      expect(@bar.get_price('Pecan Porter')).to eq(5.50)
    end

  end

  describe Bar do

    before do
      @bar = Bar.new("The Liberty")
      @bar.add_menu_item('Lone Star', 2.00)
      @bar.add_menu_item('Pecan Porter', 5.50)
    end

    it "records drink purchases" do
      @bar.drink_purchase('Lone Star')
      @bar.drink_purchase('Pecan Porter')

      expect(@bar.drink_record.count).to eq(2)
      expect(@bar.drink_record.first.name).to eq('Lone Star')
    end

    it "gets most popular drinks" do
      @bar.drink_purchase('Lone Star')
      @bar.drink_purchase('Pecan Porter')
      @bar.drink_purchase('Pecan Porter')

      expect(@bar.most_popular_drink).to eq('Pecan Porter')
    end

  end

end



