require 'spec_helper'

describe 'Employee' do

  before do
    @babbitt = TM::Employee.new("George")
  end

  it "exists" do
    expect(TM::Employee).to be_a(Class)
  end

  it "initializes employee with a name" do
    result = @babbitt.name
    expect(result).to eq("George")
  end

  it "can assign unique id to an employee" do
    result = @babbitt.id
    expect(result).to be_a(Fixnum)

  end


end
