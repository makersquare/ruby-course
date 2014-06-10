require 'spec_helper'
require 'pry-debugger'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  before(:all) do
    @project = TM::Project.new("To-Do List") 
  end

  describe '.initialize' do
    it "must have a name" do 
      expect(@project.name).to eq("To-Do List")
    end

    it "has a project id" do
      expect(@project.id).to eq(1)
    end
  end

  describe '.add_task' do
    it 'can add a task' do
      @project.add_task("Get Milk", 3)
      value = TM::Task.task_list.values.find { |t| t.project == 1 }
      
      expect(value.description).to eq("Get Milk")
    end
  end
  
  describe '.get_incomplete_tasks' do
    it 'can display all incomplete tasks in order of priority, then date' do
      project=TM::Project.new("Task List")

      project.add_task("Get Milk", 3)
      project.add_task("Take insulin", 10)
      project.add_task("Pay mortgage", 7)
      project.add_task("Get eggs", 3)

      tasks = project.get_incomplete_tasks

      expect(tasks.map { |t| t.description }).to eq(["Take insulin", "Pay mortgage", "Get Milk", "Get eggs"])
    end
  end
      
      

end

  
