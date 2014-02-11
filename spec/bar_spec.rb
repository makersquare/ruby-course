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
      # TODO: CONTROL TIME
      t = Time.now

      # Didn't fully read the Learn app at the time.
      # Should have just used Time.parse("3:30pm")
      # Used Time.parse in last two tests.
      three_thirty_pm = Time.local(t.year, t.month, t.day, 15, 30)
      Time.stub(:now).and_return(three_thirty_pm)
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      # TODO: CONTROL TIME
      x = Time.now
      four_thirty_pm = Time.local(x.year, x.month, x.day, 16, 30)
      Time.stub(:now).and_return(four_thirty_pm)
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do
    # TODO: WRITE TESTS TO ENSURE BAR KNOWS NOT TO DISCOUNT
    it "does not discount prices" do
      @bar.add_menu_item('Cosmo', 5.40)
      @bar.add_menu_item('Salty Dog', 7.80)

      t = Time.parse("6 pm")
      Time.stub(:now).and_return(t)

      expect(@bar.get_price('Cosmo')).to eq(5.40)
    end

  end

  context "During happy hours" do
    # TODO: WRITE TESTS TO ENSURE BAR DISCOUNTS DURING HAPPY HOUR
    it "does discount prices" do
      @bar.add_menu_item('Cosmo', 5.40)
      @bar.add_menu_item('Salty Dog', 7.80)

      t = Time.parse("3:30 pm")
      Time.stub(:now).and_return(t)

      expect(@bar.get_price('Cosmo')).to eq(2.70)
    end
  end
end
