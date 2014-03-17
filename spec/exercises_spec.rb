require "./exercises.rb"
require 'pry-debugger'

describe Exercises do
  it "triples a given string" do
    tripleword = Exercises.ex0("hi")
    expect(tripleword).to eq ("hihihi")
  end
end
