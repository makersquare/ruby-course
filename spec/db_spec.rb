require 'spec_helper'

describe "Project List" do
  it "contains an array of projects" do
    expect(TM::Project).to receive(:gen_id).and_return(0)
    projectlist = TM::DB.new
    projectlist.create_project("First")
    expect(projectlist.projects[0]).to be_a(TM::Project)
    expect(TM::Project).to receive(:gen_id).and_return(1)
    projectlist.create_project("Second")
    expect(projectlist.projects[1]).to be_a(TM::Project)
  end
end
