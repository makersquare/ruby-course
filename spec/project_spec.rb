require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe 'initialize' do
    it "creates a new project with a name" do
      project1 = TM::Project.new("Grades")

      expect(project1.name).to eq("Grades")
    end

    it "gives a new project a unique id" do
      project1 = TM::Project.new("Grades")
      expect(project1.id).to_not raise_error()
    end

    it "creates an empty tasks array to store project tasks" do
      project1 = TM::Project.new("Grades")
      expect(project1.tasks).to eq([])
    end
  end

  describe 'add_task' do
    it "adds a task object to the tasks array" do
      project1 = TM::Project.new("Grades")
      project1.add_task(TM::Task.new("Create gradebook", project1.id, 1))

      expect(project1.tasks.length).to eq(1)
    end
  end

  describe 'mark_complete' do

    it "marks a task as complete" do
      project1 = TM::Project.new("Grades")
      task = TM::Task.new("Create gradebook", project1.id, 1)
      expect(project1.mark_complete(task.task_id)).to eq(true)
    end

  end
end
