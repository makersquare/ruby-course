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

  	it "initialiezes with a empty tasks array" do

  	end

  end

  describe "add_task method" do

  	it "adding tasks adds it to the instance variable tasks array" do

  	end

  end

  describe "delete_task method" do
  	#delete_task(id)

  	it "returns nil if tasks array is empty" do

  	end


  	it "can delete task by task id" do

  	end

  	it "returns nil and does nothing if an invalid id is passed" do

  	end

  end

  describe "get_task_by_id method" do
  	

  	it "adding tasks adds it to the instance variable tasks array" do

  	end

  end

  describe "retrieve tasks method" do
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

  describe "sort by date method" do
  	
  end

end
