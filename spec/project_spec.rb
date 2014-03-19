require 'spec_helper'

describe 'Project' do


  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "A new project can be created with a name" do
    proj = TM::Project.new("Fitness")
    expect(proj.name).to eq "Fitness"
  end

  it "A project must automatically generate an unique id" do
    expect(TM::Project.new("Fitness").id).to eq 2
  end

  it "A project can add tasks" do
    proj = TM::Project.new("Fitness")
    expect(proj.task_list.count).to eq 0
    eating_better = TM::Task.new(1, "diet", 3, 2)
    expect(proj.add_task(eating_better).count). to eq 1
  end

  it "task can be marked as complete by its id" do
    fitness_project = TM::Project.new("Fitness")
    eating_better = TM::Task.new(1, "diet", 3, 2) #create a task with an id of 2
    fitness_project.add_task(eating_better) #add this task to fitness project
    fitness_project.mark_task_complete(2) #mark task with id 2 complete
    expect(eating_better.complete).to eq true #expect task with id2 to have complete = true
  end


end


# A new project can be created with a name
# This must automatically generate and assign the new project a unique id (you can use a class variable for this)
# A new task can be created with a project id, description, and priority number
# A task can be marked as complete, specified by id
# A project can retrieve a list of all complete tasks, sorted by creation date
# A project can retrieve a list of all incomplete tasks, sorted by priority
# If two tasks have the same priority number, the older task gets priority
