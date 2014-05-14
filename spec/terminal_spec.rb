require 'spec_helper'
require 'date'

describe 'Terminal' do
  it "exists" do
    expect(TM::Terminal).to be_a(Class)
  end

  it "allows task to be created with project id, description, and priority number" do
    x = TM::Terminal.new
    puts x
  end


end
