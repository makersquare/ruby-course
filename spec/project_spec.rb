require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end


  it "A new project can be created with a name assign the new project a unique id, also empty tasks" do
    newproject = TM::Project.new("MakerSquare")
    projectid = TM::Project.id
    expect(projectid).to eq (1)
    expect(newproject.tasklist.count).to eq 0
  end




  xit "A project can retreve a list of all complete task, via creation date" do

  end

  xit "A project can retreive a list of all incomplete tasks, sorted by priority"  do

  end

end
