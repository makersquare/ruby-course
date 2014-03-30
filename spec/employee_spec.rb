require 'spec_helper'
require './lib/task-manager/project.rb'
require './lib/task-manager/task.rb'
require './lib/task-manager/employee.rb'

describe 'Employee' do
  before do
    @employee = TM::Employee.new("John Smith")
  end

  it "exists" do
    expect(TM::Employee).to be_a(Class)
  end

  it "initializes and has a name" do
    result = @employee.name
    expect(result).to eq("John Smith")
  end

  it "initializes with an id" do
    result = @employee.eid
    expect(result.class).to eq(Fixnum)
  end



end
