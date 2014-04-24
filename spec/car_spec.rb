require 'spec_helper'

describe 'Car' do

  before do
    @car = Car.new('black')
  end

  it "initializes with a color" do
    expect(@car.color).to eq 'black'
  end

  it "throws an error if a color is not provided on initialize" do
    expect { Car.new }.to raise_error
  end

  it "honks" do
    expect(@car.honk).to eq 'meep'
  end

  it "has 4 wheels by default" do
    expect(@car.wheel_count).to eq(4)
  end
end


describe 'BigRig' do

  before do
    @truck = BigRig.new('gray')
  end

  it "initializes with a color" do
    expect(@truck.color).to eq 'gray'
  end

  it "honks" do
    expect(@truck.honk).to eq 'BBBBBRRRRRRAAAAAWWWHHHHH'
  end

  it "has 18 wheels" do
    expect(@truck.wheel_count).to eq(18)
  end
end


describe 'Motorcycle' do

  before do
    @bike = Motorcycle.new
  end

  it "is red by default" do
    expect(@bike.color).to eq 'red'
  end

  it "has 2 wheels" do
    expect(@bike.wheel_count).to eq(2)
  end
end
