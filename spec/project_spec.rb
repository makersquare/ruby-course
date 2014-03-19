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

  it "returns a list of all completed projects, by date" do
  	current_time = Time.now
  	Time.stub(:now).and_return(current_time)
  	project = TM::Project.new('project')
  	task = TM::Task.new('red',2,project.id)
  	task.complete_task

  	project.complete_task_list(task)
  	expect(project.completed_tasks_list).to eq([task])


  end

end

