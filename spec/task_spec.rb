require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "A new task can be created with a project id, description, and priority number" do
     projectid = TM::Project.id
     newtask = TM::Task.new(projectid,"teach ruby", 3)
     expect(projectid).to eq (1)
     expect(newtask.description).to eq "teach ruby"
     expect(newtask.priority).to eq 3
  end

  xit "A task can be marked as complete, specified by id"  do

  end

end


