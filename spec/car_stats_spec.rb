require 'spec_helper'

describe 'CarStats' do

  before do
    @cars = []
    3.times { @cars << Car.new('black') }
    5.times { @cars << Car.new('silver') }
    2.times { @cars << Car.new('white') }
  end

  it "calculates the most popular car color" do
    pop_color = CarStats.calc_top_color(@cars)
    expect(pop_color).to eq 'silver'
  end

  it "calculates the least popular car color" do
    bottom_color = CarStats.calc_bottom_color(@cars)
    expect(bottom_color).to eq 'white'
  end
end
