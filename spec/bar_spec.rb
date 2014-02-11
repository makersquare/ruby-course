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
      Time.stub(:now).and_return(Time.parse('3 pm'))
      expect(@bar.happy_hour?).to eq(true)
    end

    it "is not happy hour otherwise" do
      Time.stub(:now).and_return(Time.parse('10 am'))
      expect(@bar.happy_hour?).to eq(false)
    end
  end

  context "During normal hours" do

    before do
    @bar = Bar.new "The Irish Yodel"
    @bar.add_menu_item('Little Johnny', 9.95)
    end

    it "does not give a discount" do
    expect(@bar.get_price('Little Johnny')).to eq 9.95
    end

  end

  context "During happy hours" do

    before do
    @bar = Bar.new "The Irish Yodel"
    @bar.happy_discount = 0.5
    @bar.add_menu_item('Little Johnny', 9.95)
    @bar.add_menu_item('Salty Dog', 7.80)
    Time.stub(:now).and_return(Time.parse('3:30 pm'))

    end

    it "it gives customers a discount" do
    expect(@bar.get_price('Little Johnny')).to eq 4.97
    end

  end
end
