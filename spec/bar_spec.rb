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

  describe '#happy_hour?', :pending => false do
    it "knows when it is happy hour (3:00pm to 4:00pm)" do
      Time.stub(:now).and_return(Time.parse('2014-07-17 15:45:14 -0500'))
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      Time.stub(:now).and_return(Time.parse('2014-07-17 20:45:14 -0500'))
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do
    it "gets non-discounted drink prices" do
      Time.stub(:now).and_return(Time.parse('2014-07-17 20:45:14 -0500'))
      @bar.add_menu_item('Big Richard', 9.95)
      @bar.add_menu_item('Little Willy', 4.50)
      expect(@bar.get_price('Big Richard')).to eq 9.95
      expect(@bar.get_price('Little Willy')).to eq 4.50
    end
  end

  context "During happy hours" do
    it "gets discounted drink prices" do
      Time.stub(:now).and_return(Time.parse('2014-07-17 15:45:14 -0500'))
      @bar.happy_discount = 0.5
      @bar.add_menu_item('Big Richard', 9.95)
      @bar.add_menu_item('Little Willy', 4.50)
      expect(@bar.get_price('Big Richard')).to eq 4.97
      expect(@bar.get_price('Little Willy')).to eq 2.25
    end
  end
end
