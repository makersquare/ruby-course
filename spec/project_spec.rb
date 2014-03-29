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
    expect(TM::Project.new("Fitness").id).to eq 28
  end

  it "A project can add tasks" do
    proj = TM::Project.new("Fitness")
    expect(proj.task_list.count).to eq 0
    eating_better = TM::Task.new(1,2, "diet", 3)
    expect(proj.add_task(eating_better).count). to eq 1
  end

  it "task can be marked as complete by its id" do
    fitness_project = TM::Project.new("Fitness")
    eating_better = TM::Task.new(1,2, "diet", 3)
    expect(eating_better.id).to eq 21 #create a task with an id of 2
    fitness_project.add_task(eating_better) #add this task to fitness project
    fitness_project.mark_task_complete(21) #mark task with id 2 complete
    expect(eating_better.complete).to eq true #expect task with id2 to have complete = true
  end

  it " can list complete_tasks" do
    fitness_project = TM::Project.new("Fitness")
    Time.stub(:now).and_return(Time.parse("2pm"))
    eating_better = TM::Task.new(1,2, "diet", 3)
    Time.stub(:now).and_return(Time.parse("3pm"))
    sleep_8hours = TM::Task.new(1,3, "sleep", 2)
    expect(eating_better.id).to eq 22
    expect(sleep_8hours.id).to eq 23
    fitness_project.add_task(sleep_8hours) #adding in task sleep to array
    fitness_project.add_task(eating_better) #adding in task eat to array
    fitness_project.mark_task_complete(22) # taskid 2(eat) to complete=true
    fitness_project.mark_task_complete(23)
    expect(fitness_project.retrieve_complete_tasks).to eq ([eating_better,sleep_8hours])
  end

  it "can list incomplete tasks"  do
    fitness_project = TM::Project.new("Fitness")
    eating_better = TM::Task.new(1,3, "diet", 3)
    sleep_8hours = TM::Task.new(1,4, "sleep", 2)

    fitness_project.add_task(eating_better)
    fitness_project.add_task(sleep_8hours)
     # completes eating better so, sleep stil incomplete
    expect(fitness_project.retrieve_incomplete_tasks).to eq ([sleep_8hours,eating_better,])
  end






end





# A project can retrieve a list of all complete tasks, sorted by creation date
# A project can retrieve a list of all incomplete tasks, sorted by priority
# If two tasks have the same priority number, the older task gets priority
