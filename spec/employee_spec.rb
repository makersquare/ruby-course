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

end
