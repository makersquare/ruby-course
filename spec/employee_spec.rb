require 'spec_helper'
describe "Employee" do
  it "Can be create with a name" do
    guy = TM::Employee.new("A guy")
    expect(guy.name).to eq("A guy")
  end
end
