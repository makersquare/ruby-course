require 'spec_helper'

describe 'Project' do
  # it "exists" do
  #   expect(TM::Project).to be_a(Class)
  # end

  describe "initialize method" do
  	it "exists" do
  		expect(TM::Project).to be_a(Class)
  	end

  	it "can be initialized with a name" do

  	end

  	it "has a default name of 'default' if name not specified" do
  		
  	end

  	it "creates a unique ID is created starting with id=1" do

  	end

  	it "creates multiple unique IDS in numerical order" do

  	end

  	it "creates an empty @tasks[] array" do

  	end

  	it "increments global variable @@projects_count" do

  	end

  end

  describe "add_task method" do
  	# add_task(task_object)
  	it "adds given task to the @tasks[] array" do
  		# check size of array and compare actual contents
  	end

  end

  describe "get_task_by_id method" do
  	# get_task_by_id(id_num)
  	# only serches the current projects tasks[] array
  	# generic function to use in other methods

  	it "returns nil if id not found" do

  	end

  	it "returns a task object if id is found" do

  	end

  end

  describe "delete_task_by_id method" do
  	#delete_task_by_id(id)

  	it "returns nil if tasks array is empty" do

  	end


  	it "can delete task by task id" do

  	end

  	it "returns nil and does nothing if an invalid id is passed" do

  	end

  end

  describe "mark_task_completed_by_id method" do
  	# mark_task_completed_by_id(id_num)

  	it "returns nil if id not found" do

  	end

  	it "returns the correct task object" do
  		#compare task1.id == id

  	end

  end

  describe "retrieve_tasks method" do
  	# ex retrieve_tasks(by_date, by_priority, by_completed)

  	it "returns an array of task objects" do

  	end

  	it "can return tasks ordered by date created" do

  	end

  	it "can return tasks ordered by priority" do

  	end

  	it "can return just completed tasks" do

  	end


  	it "can return just incompleted tasks" do

  	end

  end

  describe "<sort_by_date></sort_by_date> method" do
  	
  end

end
