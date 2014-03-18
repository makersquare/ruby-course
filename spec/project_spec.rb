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
	  	# The id here is 3 because two instances of Project were created before
	  	expect(@project.id).to eq(3)
	  end
	end

	describe ".add_task" do
		it "should add a task to the project" do
			add_task = @project.add_task('wash clothes', 4)
			expect(@project.tasks.count).to eq(1)
		end
	end

	describe ".mark_task_complete" do
		it "should change the status of a task to 'complete'" do
			add_task = @project.add_task('wash clothes', 4)
			task_id = @project.tasks.first.id
			@project.mark_task_complete(task_id)

			expect(@project.tasks.first.status).to eq 'complete'
		end
	end

	describe ".incomplete_tasks" do
		it "shows a list of incomplete tasks ordered by priority" do
			Time.stub(:now).and_return(Time.parse('12pm'))
			eat = @project.add_task('eat', 3)
			Time.stub(:now).and_return(Time.parse('8pm'))
			sleep = @project.add_task('sleep', 5)
			Time.stub(:now).and_return(Time.parse('6pm'))
			shower = @project.add_task('shower', 5)

			expect(@project.tasks.count).to eq(3)
			expect(@project.incomplete_tasks).to eq([shower, sleep, eat])
		end
	end
end

# @books.select { |book| book if book.status == 'available' }