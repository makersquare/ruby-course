require 'pry-debugger'
require "./bar.rb"


describe Bar do
  before do
    @bar = Bar.new(
      "The Irish Yodel",
      {
        'Cosmo' => 5.40,
        'Genoa' => 12.20,
        'Sake' => 8.70,
        'Salty Dog' => 7.80,
        'Tequila' => 10.50
      })
      @drink = 'Sake'
      @regular_price = @bar.menu[@drink]
  end

  it 'has a name and menu' do
    binding.pry

    expect(@bar.name).to eq("The Irish Yodel")
    expect(@bar.menu).to eq({
        'Cosmo' => 5.40,
        'Genoa' => 12.20,
        'Sake' => 8.70,
        'Salty Dog' => 7.80,
        'Tequila' => 10.50
      })

  end

  context "During normal hours" do
    before do
      @time_now = Time.parse("6 pm")
      Time.stub(:now).and_return(@time_now)

    end

    it "getting item price shows regular price for item" do

      expect(@bar.get_price(@drink)).to eq(@bar.menu[@drink])
    end

  end

  context "During happy hours" do
    before do
      @time_now = Time.parse("2 pm")
      Time.stub(:now).and_return(@time_now)
    end

    it "getting item price shows happy hour price for item" do
      # binding.pry
      expect(@bar.get_price(@drink)).to eq(@regular_price -= @regular_price*0.10 )

    end

  end



end
