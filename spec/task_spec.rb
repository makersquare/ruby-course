require 'spec_helper'

describe 'Task' do
	before do
		@task = TM::Task.new(1, 3, "cook pasta")
	end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe ".initialize" do
    it "is initialized with a project id, priority number and description" do
    	expect(@task.project_id).to eq(1)
    	expect(@task.priority).to eq(3)
    	expect(@task.description).to eq 'cook pasta'
    end

    it "should be initialized with a unique id" do
    	TM::Task.class_variable_set :@@id_counter, 0
    	expect(TM::Task.new(1, 5, "sleep").id).to eq(1)
      expect(TM::Task.new(3, 4, "cook").id).to eq(2)
      expect(TM::Task.new(1, 1, "laundry").id).to eq(3)
    end

    it "should be initialized with an employee id of 'nil'" do
      expect(@task.employee_id).to be(nil)
    end

    it "should be initialized with a 'complete' status of 'false'" do
      expect(@task.complete).to be_false
    end

    it "sets the time when the task is created" do
    	current_time = Time.now
    	Time.stub(:now).and_return(current_time)

    	task1 = TM::Task.new(1, 2, "wash car")
    	expect(task1.created_at).to eq(current_time)
    end

    it "should be able to change complete status to true" do
      @task.complete = true
      expect(@task.complete).to be_true
    end
  end
end
