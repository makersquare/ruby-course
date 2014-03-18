require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end


  it "A new project can be created with a name assign the new project a unique id" do
    newproject = TM::Project.new("MakerSquare")
    projectid = TM::Project.id
    expect(projectid).to eq (1)
  end


  # it "A new task can be created with a name,project id, description, and priority number" do

  #   newproject = TM::Project.new("MakerSquare","Lessons on Ruby", 3)
  #   expect(newproject.description).to eq ("Lessons on Ruby")
  #   expect(newproject.name).to eq ("MakerSquare")
  #   expect(newproject.priority_number).to eq (3)
  #   expect(TM::Project.id).to eq (1)

  # end

  xit "A project can retreve a list of all complete task, via creation date"  do

  end

  xit "A project can retreive a list of all incomplete tasks, sorted by priority"  do

  end

end
