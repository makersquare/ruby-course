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

	# describe "include_task?" do
	# 	it "returns true if a project includes a task with a specified id" do
	# 		TM::Task.class_variable_set :@@id_counter, 0
	# 		eat = @project.add_task(3, 'eat')
	# 		id = eat.id

	# 		task_x = TM::Task.new(100, 1, 'dance')
	# 		id_x = task_x.id

	# 		expect(@project.include_task?(id)).to be_true
	# 		expect(@project.include_task?(id_x)).to be_false
	# 	end
	# end
end
