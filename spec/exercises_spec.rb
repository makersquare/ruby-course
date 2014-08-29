require "./exercises.rb"
require 'pry-byebug'

describe Exercises do 
  it 'returns "nope" if the string passed in is "wishes"' do
    string = "wishes"

    expect(Exercises.ex0(string)).to eq("nope")
  end

  it 'triples a string otherwise' do
    string = "triple"

    expect(Exercises.ex0(string)).to eq("tripletripletriple")
  end
end