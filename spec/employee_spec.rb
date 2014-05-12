require 'spec_helper'
require 'pry'

describe 'Employee' do

  it "exists" do
    expect(TM::Employee).to be_a(Class)
  end

end
