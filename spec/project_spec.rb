require 'spec_helper'

describe 'Project' do
  before(:each) do
    reset_class_variables(TM::Project)
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "adds all project instances to an array" do
    expect(TM::Project.project_list).to be_an_instance_of(Array)
  end

  describe "#initialize" do
    it "is initialized with a name, a unique ID, a default task list of 0, and adds itself to the project list array" do
      p = TM::Project.new("Odin")
      expect(p.name).to eq("Odin")
      expect(p.id).to eq(TM::Project.project_list.size)
      expect(p.task_list.size).to eq(0)

      p2 = TM::Project.new("Euler")
      expect(TM::Project.project_list.size).to eq(2)
      expect(p2.id).to eq(2)
      expect(p2.task_list.size).to eq(0)
    end
  end

  describe "#add_task" do
    it "adds tasks to the task array and assigns them a project id and a task id" do
      p = TM::Project.new("Euler")
      p.add_task("work", 3)
      expect(p.task_list.size).to eq(1)
      expect(p.task_list[0].task_id).to eq(0)
      expect(p.task_list[0].project_id).to eq(1)
      expect(p.task_list[0].priority_number).to eq(3)

      p.add_task("fun", 1)
      expect(p.task_list.size).to eq(2)
      expect(p.task_list[1].task_id).to eq(1)
      expect(p.task_list[1].project_id).to eq(1)
      expect(p.task_list[1].priority_number).to eq(1)
    end
  end

  describe "#mark_complete" do
    it "marks a task--specified by its ID--as complete" do
      p = TM::Project.new("Euler")
      p.add_task("work", 3)
      p.mark_complete(0)
      expect(p.task_list[0].status).to eq(true)
      expect(p.mark_complete(0)).to eq(nil)
    end
  end

  describe "#retrieve_completed_tasks" do
    it "retrieves a list of all complete tasks, sorted by creation date" do
      p = TM::Project.new("Euler")
      p.add_task("work", 3)
      p.mark_complete(0)
      p.add_task("play", 1)
      p.add_task("frollick", 2)
      p.mark_complete(2)

      completed_tasks = p.retrieve_completed_tasks
      expect(completed_tasks.size).to eq(2)
      expect(completed_tasks.first.description).to eq("work")
      expect(completed_tasks.last.description).to eq("frollick")
    end
  end
end
