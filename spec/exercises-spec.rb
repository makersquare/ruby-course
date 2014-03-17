require 'spec-helper'
require 'exercises.rb'

describe 'Exercise 0' do
  it "triples a given string" do
    result = Exercise.ex0("damn")
    expect(result).to eq("damndamndamn")
  end

end
