require 'spec_helper'

describe TM::ListAllProjects do

  it "lists all employees" do
    # Set up our data
    proj1 = TM.db.create_project('Win')
    proj2 = TM.db.create_project('All the')
    proj3 = TM.db.create_project('Things')

    result = subject.run({})
    expect(result.success?).to eq true
    expect(result.all_projects).to be_a(Array)
    expect(result.all_projects.length).to eq(3)
  end

  it "errors if there are no projects" do
    # Set up our data
    result = subject.run({})
    expect(result.error?).to eq true
    expect(result.error).to eq :no_projects_exist
  end
end
