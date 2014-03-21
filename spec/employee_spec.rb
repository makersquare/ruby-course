require 'spec_helper'

describe 'Employee' do
  it "exists" do
    expect(TM::Employee).to be_a(Class)
  end
end