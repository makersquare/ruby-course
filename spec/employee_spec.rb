require 'spec_helper'

describe 'Employee' do
  # before do
  #   @employee
  # end

  it "exists" do
    expect(TM::Employee).to be_a(Class)
  end
end