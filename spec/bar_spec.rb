require 'pry-byebug'
require "./bar.rb"


describe Bar do

  before do
    @bar = Bar.new "The Irish Yodel"
  end

  describe '.initialize' do
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

    it "has a default happy hour discount of zero" do
      expect(@bar.happy_discount).to eq 0
    end

    it "can set its happy hour discount" do
      expect { @bar.happy_discount = 0.5 }.to_not raise_error
    end
  end

  describe '#add_menu_item' do
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

  end

  describe '#happy_discount & #happy_discount=' do
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
  end

# # # # # # # # # # # # # # # # # # # # # #
  # DO NOT CHANGE SPECS ABOVE THIS LINE #
# # # # # # # # # # # # # # # # # # # # # #

  describe '#happy_hour?' do
    it "knows when it is happy hour (3:00pm to 4:00pm)" do
      my_time = Time.new(2014, 7, 17, 15, 30)  #7/17 is Thursday - REGULAR DAY
      allow(Time).to receive(:now).and_return(my_time)
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      my_time = Time.new(2014, 7, 17, 16, 30)
      allow(Time).to receive(:now).and_return(my_time)
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do
    it "normal hours = no discount" do
      @bar.happy_discount = 0.5
      my_time = Time.new(2014, 7, 17, 16, 30)
      allow(Time).to receive(:now).and_return(my_time)
      expect(@bar.happy_discount).to eq(0)
    end
  end

  context "During happy hours" do
    it "happy hour = discount" do
      @bar.happy_discount = 0.5
      my_time = Time.new(2014, 7, 17, 15, 30)
      allow(Time).to receive(:now).and_return(my_time)
      expect(@bar.happy_discount).to eq(0.5)
    end  
  end

  
  describe '#get_price' do 
    it "returns the price of the item correctly discounted during happy hour" do
      @bar.happy_discount = 0.5
      @bar.add_menu_item("Margarita", 8, true)
      margarita = @bar.menu_items.first
      my_time = Time.new(2014, 7, 17, 15, 30)
      Time.stub(:now).and_return(my_time)
      expect(@bar.get_price(margarita)).to eq(4)
    end

    it "returns full price outside of happy hour" do
      @bar.happy_discount = 0.5
      @bar.add_menu_item("Margarita", 8, true)
      margarita = @bar.menu_items.first
      my_time = Time.new(2014, 7, 17, 16, 30)
      Time.stub(:now).and_return(my_time)
      expect(@bar.get_price(margarita)).to eq(8)
    end

    context "slow days" do
      it "applies a different discount on slow days" do
        @bar.happy_discount = 0.5
        @bar.slow_day_happy_discount = 0.8
        @bar.add_menu_item("Margarita", 8, true)
        margarita = @bar.menu_items.first
        my_time = Time.new(2014, 7, 16, 15, 30) #7/16 is Weds - SLOW DAY
        Time.stub(:now).and_return(my_time)
        expect(@bar.get_price(margarita)).to eq(1.6)        
      end      
    end

    it "does not apply discount when item is not included in HH" do 
      @bar.happy_discount = 0.5
      @bar.add_menu_item("McAllen 18", 20, false)
      top_shelf = @bar.menu_items.first
      my_time = Time.new(2014, 7, 17, 15, 30)
      Time.stub(:now).and_return(my_time)
      expect(@bar.happy_hour?).to eq(true)
      expect(@bar.get_price(top_shelf)).to eq(20)    
    end
  end

  describe "#purchase" do
    it "records a purchase of an item" do
      @bar.add_menu_item("Margarita", 8, true)
      margarita = @bar.menu_items.first
      @bar.purchase(margarita)
    end
  end

end