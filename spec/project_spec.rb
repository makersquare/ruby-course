require 'spec_helper'

describe 'Project' do


  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "A new project can be created with a name" do
    TM::Project.new("Fitness")
    expect(TM::Project.new("Fitness").name).to eq "Fitness"
  end

  it "A project must automatically generate an unique id" do
    expect(TM::Project.new("Fitness").id).to eq 3
  end

  it "A project can add tasks" do
    expect(TM::Project.new("Fitness").task_list.count).to eq 0

    expect(TM::Project.new("Fitness").add_task(1,"diet",1,1).count). to eq 1
  end



end


# A new project can be created with a name
# This must automatically generate and assign the new project a unique id (you can use a class variable for this)
# A new task can be created with a project id, description, and priority number
# A task can be marked as complete, specified by id
# A project can retrieve a list of all complete tasks, sorted by creation date
# A project can retrieve a list of all incomplete tasks, sorted by priority
# If two tasks have the same priority number, the older task gets priority
