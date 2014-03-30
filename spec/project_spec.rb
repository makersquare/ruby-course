require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "can create a new project with a name" do
    expect(TM::Project).to receive(:gen_id).and_return(0)
    pl = TM::DB.new
    pl.create_project("Name")
    expect(pl.projects[0].name).to eq("Name")
    expect(pl.projects[0].project_id).to eq(0)
  end

  it "is assigned a unique id" do
    expect(TM::Project).to receive(:gen_id).and_return(0)
    pl = TM::DB.new
    pl.create_project("Name")
    expect(pl.projects[0].name).to eq("Name")
    expect(pl.projects[0].project_id).to eq(0)
  end
end
