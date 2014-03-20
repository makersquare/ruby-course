require 'spec_helper'

describe 'Project' do
	before do
		@project = TM::Project.new("SXSW")
	end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe ".initialize" do
	  it "should be initialized with a name" do
	  	expect(@project.name).to eq 'SXSW'
	  end

	  it "should be initialized with a unique id" do
	  	TM::Project.class_variable_set :@@id_counter, 0
	  	expect(TM::Project.new("Project1").id).to eq(1)
	    expect(TM::Project.new("Project2").id).to eq(2)
	    expect(TM::Project.new("Project3").id).to eq(3)
	  end
	end

	describe ".add_task" do
		it "should add a task to the project" do
			add_task = @project.add_task(4, 'wash clothes')
			expect(@project.tasks.count).to eq(1)
		end
	end

	describe ".mark_task_complete" do
		it "should change the status of a task to 'complete'" do
			add_task = @project.add_task(4, 'wash clothes')
			task_id = @project.tasks.first.id
			@project.mark_task_complete(task_id)

			expect(@project.tasks.first.status).to eq 'complete'
		end
	end

	describe ".incomplete_tasks" do
		it "returns a list of incomplete tasks ordered by priority" do
			Time.stub(:now).and_return(Time.parse('12pm'))
			eat = @project.add_task(3, 'eat')
			Time.stub(:now).and_return(Time.parse('8pm'))
			sleep = @project.add_task(5, 'sleep')
			Time.stub(:now).and_return(Time.parse('6pm'))
			shower = @project.add_task(5, 'shower')

			expect(@project.tasks.count).to eq(3)
			expect(@project.incomplete_tasks).to eq([shower, sleep, eat])
		end
	end

	describe ".complete_tasks" do
		it "returns a list of complete tasks ordered by creation date" do
			TM::Task.class_variable_set :@@id_counter, 0
			Time.stub(:now).and_return(Time.parse('12pm'))
			eat = @project.add_task(3, 'eat')					
			Time.stub(:now).and_return(Time.parse('8pm'))
			sleep = @project.add_task(5, 'sleep')				
			Time.stub(:now).and_return(Time.parse('6pm'))
			shower = @project.add_task(5, 'shower')				

			@project.mark_task_complete(1) # eat.id
			@project.mark_task_complete(2) # sleep.id 
			@project.mark_task_complete(3) # shower.id 

			expect(@project.tasks.count).to eq(3)
			expect(@project.complete_tasks).to eq([eat, shower, sleep])
		end
	end

	describe "include_task?" do
		it "returns true if a project includes a task with a specified id" do
			TM::Task.class_variable_set :@@id_counter, 0
			eat = @project.add_task(3, 'eat')
			id = eat.id

			task_x = TM::Task.new(100, 1, 'dance')
			id_x = task_x.id

			expect(@project.include_task?(id)).to be_true
			expect(@project.include_task?(id_x)).to be_false
		end
	end
end
