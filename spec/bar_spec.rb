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

    it "gives a 50% discount on Monday" do
      @bar.add_menu_item('Long Island', 9.30)
      @bar.add_menu_item('Cosmo', 12.25)
      @bar.add_menu_item('Bloody Mary', 6.10)

      Time.stub(:now).and_return(Time.local(2014, "Feb", 10, 15, 30))

      @bar.set_discount

      expect(@bar.happy_discount).to eq(0.50)
    end

    it "gives a 50% discount on Wednesday" do
      @bar.add_menu_item('Long Island', 9.30)
      @bar.add_menu_item('Cosmo', 12.25)
      @bar.add_menu_item('Bloody Mary', 6.10)

      Time.stub(:now).and_return(Time.local(2014, "Feb", 12, 15, 30))

      @bar.set_discount

      expect(@bar.happy_discount).to eq(0.50)
    end

    it "gives a 25% discount on other Happy Hours" do
      @bar.add_menu_item('Long Island', 9.30)
      @bar.add_menu_item('Cosmo', 12.25)
      @bar.add_menu_item('Bloody Mary', 6.10)

      Time.stub(:now).and_return(Time.local(2014, "Feb", 11, 15, 30))

      @bar.set_discount

      expect(@bar.happy_discount).to eq(0.25)
    end

  end

  context "Exempt drinks" do
    it "exempts certain drinks from Happy Hour discount specials" do
      @bar.add_menu_item('Long Island', 9.30)
      @bar.add_menu_item('Cosmo', 12.25)
      @bar.add_menu_item('Bloody Mary', 6.10)

      @bar.exempt('Cosmo')

      Time.stub(:now).and_return(Time.local(2014, "Feb", 11, 15, 30))

      expect(@bar.get_price('Cosmo')).to eq(12.25)

    end

  end







end
