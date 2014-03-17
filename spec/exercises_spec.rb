require "pry-debugger"
require "./exercises.rb"

describe Exercises do
  it "triples a given string" do
    result = Exercises.ex0("brady")
    expect(result).to eq("bradybradybrady")
  end
end

