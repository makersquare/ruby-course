require 'spec_helper'
describe "Employee" do
  it "Can be create with a name" do
    guy = TM::Employee.new("A guy")
    expect(guy.name).to eq("A guy")
  end

  it "Automatically generates and assigns a unique id" do
    newguy = TM::Employee.new("Name")
    expect(newguy.employee_id).to be_a(Integer)
  end
end
