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
      Time.stub(:now).and_return(Time.parse('3pm'))
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      # TODO: CONTROL TIME
      Time.stub(:now).and_return(Time.parse('2pm'))
      expect(@bar.happy_hour?).to eq(false)
    end

    it "returns the price for a given drink name" do
      @bar.add_menu_item('Long Island', 9.30)
      @bar.add_menu_item('Cosmo', 12.25)
      @bar.add_menu_item('Bloody Mary', 6.10)

      expect(@bar.get_price('Cosmo')).to eq(12.25)

    end

  end

  context "During normal hours" do
    # TODO: WRITE TESTS TO ENSURE BAR KNOWS NOT TO DISCOUNT
    it "does not give a discount on drinks" do
      @bar.add_menu_item('Long Island', 9.30)
      @bar.add_menu_item('Cosmo', 12.25)
      @bar.add_menu_item('Bloody Mary', 6.10)

      Time.stub(:now).and_return(Time.parse('1pm'))

      expect(@bar.get_price('Long Island')).to eq(9.30)
    end

  end

  context "During happy hours" do
    # TODO: WRITE TESTS TO ENSURE BAR DISCOUNTS DURING HAPPY HOUR

    it "gives out a discount on drinks" do
      @bar.add_menu_item('Long Island', 9.30)
      @bar.add_menu_item('Cosmo', 12.25)
      @bar.add_menu_item('Bloody Mary', 6.10)

      Time.stub(:now).and_return(Time.parse('3pm'))

      @bar.happy_discount = 0.5

      expect(@bar.get_price('Long Island')).to eq(4.65)
    end
  end


  context "Monday and Wednesday special" do

    xit "gives a 50% discount" do
      @bar.add_menu_item('Long Island', 9.30)
      @bar.add_menu_item('Cosmo', 12.25)
      @bar.add_menu_item('Bloody Mary', 6.10)

      Time.stub_chain(:now,:monday?).and_return(true)

      expect(@bar.happy_discount).to eq(0.5)
    end


  end







end
