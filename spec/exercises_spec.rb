require "rspec"
require "./exercises.rb"



describe Exercises do

  it "returns strings times three or nope" do

    ans = Exercises.ex0("str")

    expect(ans).to eq "strstrstr"

    ans = Exercises.ex0("wishes")

    expect(ans).to eq "nope"

  end


end