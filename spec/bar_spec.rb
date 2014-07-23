require 'pry-byebug'
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
      Time.stub(:now).and_return(Time.parse("2011-1-2 15:00:00"))
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      Time.stub(:now).and_return(Time.parse("2011-1-2 16:00:01"))
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do
       it "Discount can not be applied" do
         expect(@bar.happy_discount).to eq (0)
       end
  end

  #Test: 
  #context "During happy hours" do
  #    Time.stub(:now).and_return(15)
  #    it "Discount Works during Happy Hour" do
  #         expect(@bar.happy_hour?).to eq true
  #         @bar.happy_discount = 0.06
  #         expect(@bar.happy_discount).to eq 0.06 

  #    end
  # end

  describe 'get_price function' do
  before do
    @bar.add_menu_item('dirty harry', 9.95)
  end
  it "applies discount during happy_hour" do
       Time.stub(:now).and_return(Time.parse("2011-1-2 15:00:00"))
       @bar.happy_discount =0.07
       expect(@bar.get_price('dirty harry')).to eq(9.25)
  end
  it "applies does not discount when happy_hour is over" do
       Time.stub(:now).and_return(Time.parse("2011-1-2 17:00:00"))
       @bar.happy_discount =0.07
       expect(@bar.get_price('dirty harry')).to eq(9.95)
  end
  it " shows that said Item doesn't exist on the menu" do
      expect(@bar.get_price('fuzzy navel')).to eq("Item does not exist.")
  end
end
end

describe "Owner's specified scenario" do
  before do
    @bar = Bar.new "The Irish Yodel"
    @bar.add_menu_item('dirty harry', 9.95)
    @bar.add_menu_item('le', 4.45)
    @bar.add_menu_item('dv', 4.56)
    @bar.get_price('dv')
    @bar.get_price('dv')
    @bar.get_price('dv')
    @bar.get_price('le')
    @bar.get_price('le')
  end

  it "Monday and Wendsday Disc." do
      Time.stub(:now).and_return(Time.parse("2014-7-21 15:00:00"))
      expect(@bar.set_discount).to eq(0.50)
      Time.stub(:now).and_return(Time.parse("2014-7-22 15:00:00"))
      expect(@bar.set_discount).to eq(0.25)
  end

  it "Popularity" do
      expect(@bar.most_pop).to eq('dv')
  end
end
