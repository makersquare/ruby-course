require 'spec_helper'

describe 'Task' do
	before do
		@task = TM::Task.new(1, "cook pasta", 3)
	end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "is initialized with a project id, description and priority number" do
  	expect(@task.project_id).to eq(1)
  	expect(@task.description).to eq 'cook pasta'
  	expect(@task.priority).to eq(3)
  end

  it "should be initialized with a unique id" do
  	# The id here is 11 because 10 instances of Task were created before
  	# between project_spec and task_spec
  	expect(@task.id).to eq(11)
  end

  it "sets the time when the task is created" do
  	current_time = Time.now
  	Time.stub(:now).and_return(current_time)

  	task1 = TM::Task.new(1, "wash car", 2)
  	expect(task1.created_at).to eq(current_time)
  end
end
