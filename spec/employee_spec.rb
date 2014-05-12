require 'spec_helper'
require 'pry'

describe 'Employee' do
  before(:each) do
    @db = TM.db
    @db.create_employee(name: "Jason")
    @db.create_project(name: "New Project")
    @employee1 = @db.get_employee(1)
  end

  it "exists" do
    expect(TM::Employee).to be_a(Class)
  end

  it 'can assign an employee to a project' do
    @employee1.assign_project(1)
    expect(@db.project_membership[1]).to eq({ 1 => true })
  end

  it 'can remove an employee from a project' do
    @employee1.remove_project(1)
    expect(@db.project_membership[1]).to eq({})
  end

end
