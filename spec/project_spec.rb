require 'spec_helper'
# require_relative '../lib/task-manager/task'

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
  	it "adds given task to the @tasks[] array" do
  		# check size of array and compare actual contents
  		project1 = TM::Project.new("project1")
  		task1 = TM::Task.new("task1")
  		project1.add_task(task1)
  		expect(project1.tasks.size).to eq(1)
  		expect(project1.tasks[0].name).to eq("task1")
  	end

  	it "should not add anything if not a valid task object" do
  		# check size of array and compare actual contents
  		#throw error? how to test that?
  		project1 = TM::Project.new("project1")
  		task1 = "i'm just a string"
  		project1.add_task(task1)
  		expect(project1.tasks.size).to eq(0)
  	end

  end

  describe "get_task_by_id method" do
  	# get_task_by_id(id_num)
  	# only serches the current projects tasks[] array
  	# generic function to use in other methods

  	it "returns nil if id not found" do
  		project1 = TM::Project.new("project1")
  		task1 = TM::Task.new("task1")
  		task1.set_id(50)
  		project1.add_task(task1)
  		expect(project1.get_task_by_id(99)).to eq(nil)
  	end

  	it "returns a task object if id is found" do
  		project1 = TM::Project.new("project1")
  		task1 = TM::Task.new("task1")
  		task1.set_id(50)
  		project1.add_task(task1)
  		expect(project1.get_task_by_id(50)).to eq(task1)
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

  	it "returns nil if id not found and does nothing to array" do
  		project1 = TM::Project.new("project1")
  		task1 = TM::Task.new("task1")
  		task1.set_id(50)
  		project1.add_task(task1)
  		expect(project1.tasks[0].completed).to eq(false)
  		expect(project1.mark_task_completed_by_id(99)).to eq(nil)
  		expect(project1.tasks[0].completed).to eq(false)
  	end

  	it "marks the correct task object" do
  		#compare task1.id == id
  		project1 = TM::Project.new("project1")
  		task1 = TM::Task.new("task1")
  		task1.set_id(50)
  		project1.add_task(task1)
  		expect(project1.tasks[0].completed).to eq(false)
  		project1.mark_task_completed_by_id(50)
  		expect(project1.tasks[0].completed).to eq(true)
  	end

  end

  describe "retrieve_tasks method" do
  	# ex retrieve_tasks(by_date, by_priority, by_completed)

  	it "returns an array of task objects" do
      project1 = TM::Project.new("project1")
      task1 = TM::Task.new("task1")
      task1.mark_completed
      task1.set_date_created(Time.parse("1/1/2014"))
      task2 = TM::Task.new("task2")
      task2.mark_completed
      task2.set_date_created(Time.parse("2/1/2014"))
      task3 = TM::Task.new("task3")
      task3.mark_completed
      task3.set_date_created(Time.parse("3/1/2014"))
      
      project1.add_task(task1)
      project1.add_task(task2)
      project1.add_task(task3)

      task_array = project1.retrieve_completed_tasks_by_date
      expect(task_array.size).to eq(3)
      expect(task_array[0].name).to eq("task3")
      expect(task_array[1].name).to eq("task2")
      expect(task_array[2].name).to eq("task1")


    end

    xit "can return tasks ordered by date created, most recent date first" do

    end

    xit "can return tasks ordered by date created, earliest date first" do

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
