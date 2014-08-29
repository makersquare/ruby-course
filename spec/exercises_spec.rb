require 'rubygems'
require 'rspec'
require 'pry-byebug'
require_relative '../exercises.rb'

describe 'Exercise 0' do
  it "triples the length of a string" do
    result = Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if the string is 'wishes'" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end
end


# describe 'Exercise 2' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 3' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 4' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 5' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 6' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 7' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 8' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 9' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 10' do
#   it "triples the length of a string" do
#   end
# end
