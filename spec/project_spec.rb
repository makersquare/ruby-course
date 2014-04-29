require 'spec_helper'

describe 'Project' do
  # it "exists" do
  #   expect(TM::Project).to be_a(Class)
  # end

  describe "initialize method" do

  	it "can be initialized with a name" do
  		project1 = TM::Project.new("project1")
  		expect(project1.name).to eq("project1")
  	end

  	it "has a default name of 'default' if name not specified" do
  		project1 = TM::Project.new
  		expect(project1.name).to eq("default")
  	end

  	it "creates a unique ID is created starting with id=1" do
  		project1 = TM::Project.new
  		expect(project1.id).to eq(3)
  	end

  	it "creates multiple unique IDS in numerical order" do
  		project1 = TM::Project.new
  		project2 = TM::Project.new
  		project3 = TM::Project.new
  		expect(project1.id).to eq(4)
  		expect(project2.id).to eq(5)
  		expect(project3.id).to eq(6)
  	end

  	it "creates an empty @tasks[] array" do
  		project1 = TM::Project.new
  		expect(project1.tasks.size).to eq(0)
  	end

  end

  describe "add_task method" do
  	# add_task(task_object)
  	xit "adds given task to the @tasks[] array" do
  		# check size of array and compare actual contents
  	end

  end

  describe "get_task_by_id method" do
  	# get_task_by_id(id_num)
  	# only serches the current projects tasks[] array
  	# generic function to use in other methods

  	xit "returns nil if id not found" do

  	end

  	xit "returns a task object if id is found" do

  	end

  end

  describe "delete_task_by_id method" do
  	#delete_task_by_id(id)

  	xit "returns nil if tasks array is empty" do

  	end


  	xit "can delete task by task id" do

  	end

  	xit "returns nil and does nothing if an invalid id is passed" do

  	end

  end

  describe "mark_task_completed_by_id method" do
  	# mark_task_completed_by_id(id_num)

  	xit "returns nil if id not found" do

  	end

  	xit "returns the correct task object" do
  		#compare task1.id == id

  	end

  end

  describe "retrieve_tasks method" do
  	# ex retrieve_tasks(by_date, by_priority, by_completed)

  	xit "returns an array of task objects" do

  	end

  	xit "can return tasks ordered by date created" do

  	end

  	xit "can return tasks ordered by priority" do

  	end

  	xit "can return just completed tasks" do

  	end


  	xit "can return just incompleted tasks" do

  	end

  end

  describe "sort_by_date method" do
  	
  end

end
