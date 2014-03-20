require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "can be initialized with a name" do
  	project = TM::Project.new("project")
 	expect(project.name).to eq("project")

  end

  it "upon initialization, it can generate a unique id" do   
  	project = TM::Project.new("project")
  	expect(project.id).to eq(1)

  	project2 = TM::Project.new('project2')
  	expect(project2.id).to eq(2)

  end

  it "returns a list of all completed tasks, by date" do
  	current_time = Time.now
  	project = TM::Project.new('project')
  	
  	Time.stub(:now).and_return(current_time)
  	task = TM::Task.new('red', 2, project.id)
  	task.complete_task

  	Time.stub(:now).and_return(current_time + 60)
  	task2 = TM::Task.new('red', 2, project.id)
  	task2.complete_task

  	expect(project.completed_tasks_list).to eq([task2, task])

  	# TM::Project.complete_task_list(task)
  	# expect(TM::Project.completed_tasks_list).to eq([task])


  end

  it "returns a list of all incomplete tasks" do
  	current_time = Time.now
  	Time.stub(:now).and_return(current_time)
  	project = TM::Project.new('project')
  	task = TM::Task.new('red',2,project.id)

  	project.incomplete_task_list(task)
  	expect(project.incompleted_tasks_list).to eq([task])

  	time = Time.parse('3pm')
  	Time.stub(:now).and_return(time)
  	project2 = TM::Project.new('project2')
  	task2 = TM::Task.new('red',2,project.id)

  	project2.incomplete_task_list(task2)
  	expect(project2.incompleted_tasks_list).to eq([task,task2])

   end
end

