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
  context "Purchasing and logging popular drinks" do

    before do
        @bar = Bar.new "The Irish Yodel"
        @bar.add_menu_item('Cosmo', 5.40)
        @bar.add_menu_item('Martini', 7.00, discount: false)
        @bar.add_menu_item('PBR', 3.50)
      end
    describe '#purchase_drink' do
      it 'allows you to order a drink' do

        @bar.purchase_drink('Cosmo')
      end

      it 'allows you to log ordered drinks' do
        @bar.purchase_drink('Cosmo')
        @bar.purchase_drink('Martini')
        @bar.purchase_drink('PBR')

        expect(@bar.drinks_ordered.count).to eq 3
      end
    end

    describe 'self.calc_top_selling_drinks' do
      it 'displays frequency of purchased drinks' do
        3.times { @bar.purchase_drink('Cosmo') }
        9.times { @bar.purchase_drink('PBR') }
        2.times { @bar.purchase_drink('Martini') }

        drinks = @bar.calc_top_selling_drinks

        expect(drinks[0][0]).to eq("PBR")
        expect(drinks[1][0]).to eq("Cosmo")
        expect(drinks[2][0]).to eq("Martini")
      end
    end
  end
  describe '#happy_hour', :pending => false do
    it "knows when it is happy hour (3:00pm to 4:00pm)" do
      # TODO: CONTROL TIME
      @time_3pm = Time.parse("3 pm")
      Time.stub(:now).and_return(@time_3pm)

      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      # TODO: CONTROL TIME
      @time_8pm = Time.parse("8 pm")
      Time.stub(:now).and_return(@time_8pm)
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do
    #TODO: WRITE TESTS TO ENSURE BAR KNOWS NOT TO DISCOUNT
    before do
      @bar = Bar.new "The Irish Yodel"
      @bar.add_menu_item('Cosmo', 5.40)
      @time_8pm = Time.parse("8 pm")
      Time.stub(:now).and_return(@time_8pm)
    end

    it "returns a price for a given drink name" do
    expect(@bar.get_price('Cosmo')).to eq(5.40)
    end
  end

  context "During happy hours" do
    # TODO: WRITE TESTS TO ENSURE BAR DISCOUNTS DURING HAPPY HOUR

# binding.pry
    before do
      @bar = Bar.new "The Irish Yodel"
      @bar.add_menu_item('Cosmo', 5.40)
      # @bar.happy_discount = 0.5
    end

    it "returns a price * 0.5 for a given drink name during busy days (Any day except Mon and Wed)" do
      @time_friday_3pm = Time.parse("Feb 6 1981 3 pm") # Feb 6 1981 is a friday
      Time.stub(:now).and_return(@time_friday_3pm)

      expect(@bar.get_price('Cosmo')).to eq(5.40 * 0.5)
    end

    it "returns price * 0.25 for a given drink name during Monday happy hour" do
      @time_monday_3pm = Time.parse("Feb 2 1981 3 pm") # Feb 2 1981 is a Monday
      Time.stub(:now).and_return(@time_monday_3pm)

      expect(@bar.get_price('Cosmo')).to eq(5.40 * 0.25)
    end

    it "returns price * 0.25 for a given drink name during Wednesday happy hour" do
      @time_wednesday_3pm = Time.parse("Feb 4 1981 3 pm") # Feb 4 1981 is a Wednesday
      Time.stub(:now).and_return(@time_wednesday_3pm)

      expect(@bar.get_price('Cosmo')).to eq(5.40 * 0.25)
    end

    it "does not allow menu_item with discount: false to receive happy hour discount" do
      @time_friday_3pm = Time.parse("Feb 6 1981 3 pm") # Feb 6 1981 is a friday
      @bar.add_menu_item("Spensive Drank", 9.00, discount: false)
      Time.stub(:now).and_return(@time_friday_3pm)
# binding.pry
      expect(@bar.get_price("Spensive Drank")).to eq(9.00)
    end
  end
end
