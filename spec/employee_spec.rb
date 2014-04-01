require 'spec_helper'

describe "Employee" do

  it "exists" do
    expect(TM::Employee).to be_a(Class)

  end

  it "creates an employee with a unique ID" do
    bob = TM::Employee.new("bob")
    expect(bob.id).to eq 29
  end

  it "creates an employee with a name" do
    bob = TM::Employee.new("bob")
    expect(bob.name).to eq "bob"
  end

end
