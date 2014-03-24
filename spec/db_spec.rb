require 'spec_helper'

describe "Project List" do

  before do
    @projectlist = TM::DB.new
    @projectlist.create_project("Project Name")
    @projectlist.create_employee("Employee Name")
  end

  it "contains a hash of projects accessible by index with get_project added by create_project" do
    expect(@projectlist.get_project(0)).to be_a(TM::Project)
    @projectlist.create_project("Second")
    expect(@projectlist.get_project(1)).to be_a(TM::Project)
  end
end
