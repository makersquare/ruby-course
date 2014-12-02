require "rspec"
require "./exercises.rb"



describe Exercises do

  it "returns strings times three or nope" do

    ans = Exercises.ex0("str")

    expect(ans).to eq "strstrstr"

    ans = Exercises.ex0("wishes")

    expect(ans).to eq "nope"

  end

  it "return items in array" do

    ans = Exercises.ex1([0,5,6,7,8])

    expect(ans).to eq 5

    ans = Exercises.ex1([])

    expect(ans).to eq 0

  end


end