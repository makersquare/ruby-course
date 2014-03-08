require 'pry-debugger'
require "./bar.rb"

# Store some times for later easy use
monday_happy_hour = Time.new(2014, 3, 3,  15, 0, 0)  # Monday Happy Hour
tuesday_happy_hour = Time.new(2014, 3, 4,  15, 0, 0) # Tuesday Happy Hour
wednesday_happy_hour = Time.new(2014, 3, 5,  15, 0, 0) # Wednesday Happy Hour
tuesday_regular_hour = Time.new(2014, 3, 4,  12, 0, 0)


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
    Time.stub(:now).and_return(Time.parse('9 pm'))
    expect(@bar).to receive(:happy_hour?).and_return(false)
    expect(@bar.happy_discount).to eq 0

    Time.stub(:now).and_return(Time.parse('4 pm'))
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

  describe '#happy_hour' do
    it "knows when it is happy hour (3:00pm to 4:00pm)" do
      Time.stub(:now).and_return(Time.parse('4:30 pm'))
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      Time.stub(:now).and_return(Time.parse('9 pm'))
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do
    # TODO: WRITE TESTS TO ENSURE BAR KNOWS NOT TO DISCOUNT
    before do
      @bar.add_menu_item("Coccaine", 150)
      @bar.add_menu_item("Beer", 2.50)
      @bar.add_menu_item("Earplugs", 0)
      @bar.happy_discount = 0.5
    end

    it "does not discount prices during normal hours" do
      Time.stub(:now).and_return(Time.parse('9 pm'))  #not happy hour

      expect(@bar.current_price(@bar.menu_items[0])).to eq(150)
      expect(@bar.current_price(@bar.menu_items[1])).to eq(2.50)
      expect(@bar.current_price(@bar.menu_items[2])).to eq(0)
    end

    context "During happy hours" do
      # TODO: WRITE TESTS TO ENSURE BAR DISCOUNTS DURING HAPPY HOUR
      it "does discount prices during happy hour" do
        Time.stub(:now).and_return(Time.new(2014, 3, 3, 15, 0, 0))  # happy hour

        expect(@bar.current_price(@bar.menu_items[0])).to eq(75)
        expect(@bar.current_price(@bar.menu_items[1])).to eq(1.25)
        expect(@bar.current_price(@bar.menu_items[2])).to eq(0)
      end

    end # end context

    before do
      @bar.add_menu_item("Coccaine", 150)
      @bar.add_menu_item("Beer", 2.50)
      @bar.add_menu_item("Earplugs", 0)
      @bar.happy_discount = 0.25
      @bar.happy_discount = [:monday, 0.5]
      @bar.happy_discount = [:wednesday, 0.5]
    end

    it "discounts 25% for any day but Mon & Wed" do
      Time.stub(:now).and_return(Time.new(2014, 3, 3,  15, 0, 0))
      expect(@bar.happy_discount).to eq(0.50)

      Time.stub(:now).and_return(Time.new(2014, 3, 5,  15, 0, 0))
      expect(@bar.happy_discount).to eq(0.50)

      Time.stub(:now).and_return(Time.new(2014, 3, 4,  15, 0, 0))
      expect(@bar.happy_discount).to eq(0.25)
    end

    it "applies proper discounts for proper weekdays"do
      Time.stub(:now).and_return(monday_happy_hour)
      expect(@bar.current_price(@bar.menu_items[0])).to eq(75)

      Time.stub(:now).and_return(wednesday_happy_hour) # Wednesday Happy Hour
      expect(@bar.current_price(@bar.menu_items[1])).to eq(1.25)

      Time.stub(:now).and_return(tuesday_happy_hour) # Tuesday Happy Hour
      expect(@bar.current_price(@bar.menu_items[0])).to eq(112.5)
    end

    it "does not apply discount to exempt items" do
      @bar.menu_items[0].special_discount = 0

      Time.stub(:now).and_return(monday_happy_hour)  # Monday Happy Hour
      expect(@bar.current_price(@bar.menu_items[0])).to eq(150)

      Time.stub(:now).and_return(wednesday_happy_hour) # Wednesday Happy Hour
      expect(@bar.current_price(@bar.menu_items[1])).to eq(1.25)

      Time.stub(:now).and_return(tuesday_happy_hour) # Tuesday Happy Hour
      expect(@bar.current_price(@bar.menu_items[0])).to eq(150)
    end

    it "applies special_discount if appropriate" do
      @bar.menu_items[0].special_discount = 0.9

      Time.stub(:now).and_return(monday_happy_hour)  # Monday Happy Hour
      expect(@bar.current_price(@bar.menu_items[0])).to eq(15)

      Time.stub(:now).and_return(wednesday_happy_hour) # Wednesday Happy Hour
      expect(@bar.current_price(@bar.menu_items[1])).to eq(1.25)

      Time.stub(:now).and_return(tuesday_happy_hour) # Tuesday Happy Hour
      expect(@bar.current_price(@bar.menu_items[0])).to eq(15)
    end

    it "can change special_discount back to nil" do
      @bar.menu_items[0].special_discount = 0.9

      Time.stub(:now).and_return(monday_happy_hour)  # Monday Happy Hour
      expect(@bar.current_price(@bar.menu_items[0])).to eq(15)


      Time.stub(:now).and_return(wednesday_happy_hour) # Wednesday Happy Hour
      expect(@bar.current_price(@bar.menu_items[1])).to eq(1.25)

      @bar.menu_items[0].special_discount = -1  # Turn it back to a normal item

      Time.stub(:now).and_return(tuesday_happy_hour) # Tuesday Happy Hour
      expect(@bar.current_price(@bar.menu_items[0])).to eq(112.5)
    end


    it "stores information about transactions" do

      Time.stub(:now).and_return(tuesday_regular_hour) # Tuesday non-Happy Hour
      @bar.ring_sale(@bar.menu_items[0])
      Time.stub(:now).and_return(monday_happy_hour)  # Monday Happy Hour
      @bar.ring_sale(@bar.menu_items[1])

      expect(@bar.transactions[0].happy_hour).to eq(false)
      expect(@bar.transactions[0].time_of_transaction).to eq(tuesday_regular_hour)
      expect(@bar.transactions[0].price).to eq(150)
      expect(@bar.transactions[0].item.name).to eq(@bar.menu_items[0].name)

      Time.stub(:now).and_return(tuesday_regular_hour) # Tuesday non-Happy Hour
      @bar.ring_sale(@bar.menu_items[1])

      expect(@bar.transactions[2].happy_hour).to eq(false)
      expect(@bar.transactions[2].time_of_transaction).to eq(tuesday_regular_hour)
      expect(@bar.transactions[2].price).to eq(2.50)
      expect(@bar.transactions[2].item.name).to eq(@bar.menu_items[1].name)
      expect(@bar.transactions.count).to eq(3)
    end

    it "rubs the lotion on its skin or else it gets the hose" do
    end

    it "can return a list of sales in order of most popular items" do

      # ring some stuff Tuesday non-happy-hour
      Time.stub(:now).and_return(tuesday_regular_hour) # Tuesday non-Happy Hour
      8.times { @bar.ring_sale(@bar.menu_items[0]) }
      4.times { @bar.ring_sale(@bar.menu_items[2]) }

      # ring some stuff Monday happy-hour
      Time.stub(:now).and_return(monday_happy_hour)  # Monday Happy Hour
      10.times { @bar.ring_sale(@bar.menu_items[1]) }
      12.times { @bar.ring_sale(@bar.menu_items[0]) }

      expect(@bar.most_popular_drinks[0][0].name).to eq(@bar.menu_items[0].name)
      expect(@bar.most_popular_drinks[0][1]).to eq(20)
      expect(@bar.most_popular_drinks.count).to eq(3)

    end










  end

end
