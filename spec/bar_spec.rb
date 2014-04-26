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
      allow(Time).to receive(:now).and_return(Time.parse("3pm"))
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      allow(Time).to receive(:now).and_return(Time.parse("8am"))
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do
    it "returns regular price during normal hours" do
      @bar.add_menu_item('Little Johnny', 9.95)
      allow(Time).to receive(:now).and_return(Time.parse("1pm"))
      expect(@bar.get_price('Little Johnny')).to eq(9.95)
    end
  end

  context "During happy hours on Monday or Wednesday" do
    it "returns full discounted price during happy hour" do
      @bar.add_menu_item('Little Johnny', 9.95)
      allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
      allow(Date).to receive(:today).and_return(Date.parse("wednesday"))
      expect(@bar.get_price('Little Johnny')).to eq((9.95 * 0.5).round(2))
    end
  end

  context "During happy hours not on Monday or Wednesday" do
    it "returns partial discounted price" do
      @bar.add_menu_item('Little Johnny', 9.95)
      allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
      allow(Date).to receive(:today).and_return(Date.parse("tuesday"))
      expect(@bar.get_price('Little Johnny')).to eq((9.95 * 0.25).round(2))
    end
  end

  context "Some drinks are exempt from happy hour" do
    it "returns normal price for exempt drink during happy hour" do
      @bar.add_menu_item('Little Johnny', 9.95)
      # binding.pry
      @bar.exempt_drink('Little Johnny')
      allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
      allow(Date).to receive(:today).and_return(Date.parse("tuesday"))
      expect(@bar.get_price('Little Johnny')).to eq(9.95)
    end
  end

  describe "discount for specific day" do

    context "given a day for the discount" do
      it "returns the right discount" do
        expect(@bar.discount_for_day(Date.parse("tuesday").wday)).to eq(0.25)
      end
    end

    context "can update the discount" do
      it "receives a day and discount and updates correctly" do
        @bar.add_menu_item('Little Johnny', 9.95)
        @bar.update_discount("Friday", 0.35)
        allow(Date).to receive(:today).and_return(Date.parse("friday"))
        allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
        expect(@bar.get_price('Little Johnny')).to eq((9.95 * 0.35).round(2))
      end
    end
  end

  describe "discount for specific item" do

    context "a drink is ordered during happy our" do
      it "has a unique discount" do
        @bar.add_menu_item('Little Johnny', 9.95)
        allow(Date).to receive(:today).and_return(Date.parse("monday"))
        allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))
        @bar.unique_discount('Little Johnny', 0.75)

        expect(@bar.get_price('Little Johnny')).to eq((9.95 * 0.75).round(2))
      end
    end
  end

  describe "#order_track" do

    it "knows how many drinks are purchased" do
      @bar.add_menu_item('Little Johnny', 9.95)
      @bar.add_menu_item('JayJay', 9.95)
      @bar.add_menu_item('Texas Tea', 9.95)
      @bar.purchase('Texas Tea')
      @bar.purchase('Texas Tea')
      @bar.purchase('Texas Tea')
      @bar.purchase('JayJay')
      @bar.purchase('JayJay')
      @bar.purchase('Little Johnny')

      expect(@bar.total_purchases).to eq(6)
    end

    it "list the most popular drinks" do
      @bar.add_menu_item('Little Johnny', 9.95)
      @bar.add_menu_item('JayJay', 9.95)
      @bar.add_menu_item('Texas Tea', 9.95)
      @bar.purchase('Texas Tea')
      @bar.purchase('Texas Tea')
      @bar.purchase('Texas Tea')
      @bar.purchase('JayJay')
      @bar.purchase('JayJay')
      @bar.purchase('Little Johnny')

      expect(@bar.most_popular).to eq(["Texas Tea: 3", "JayJay: 2", "Little Johnny: 1"])
    end

    context "a drink is ordered during happy hour" do
      it "keeps count of drinks during happy hour" do
        @bar.add_menu_item('Little Johnny', 9.95)
        @bar.add_menu_item('JayJay', 9.95)
        @bar.add_menu_item('Texas Tea', 9.95)
        @bar.purchase('Texas Tea')
        @bar.purchase('Texas Tea')
        @bar.purchase('Texas Tea')
        @bar.purchase('JayJay')
        @bar.purchase('JayJay')
        @bar.purchase('Little Johnny')
        allow(Date).to receive(:today).and_return(Date.parse("monday"))
        allow(Time).to receive(:now).and_return(Time.parse("3:30pm"))

        expect(@bar.happy_hour_purchases).to eq(6)
      end
    end
  end
end



