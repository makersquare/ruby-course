require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe 'initialize' do

    it "Creates a task that has a description" do
      project1 = TM::Project.new("Grades")
      task = TM::Task.new("Create gradebook", project1.id, 1)
      expect(task.description).to eq("Create gradebook")
    end

    it "Creates a task that assigns the project's id to it" do
      project1 = TM::Project.new("Grades")
      task = TM::Task.new("Create gradebook", project1.id, 1)
      expect(task.project_id).to eq(project1.id)
    end

    it "Creates a task that has a priority number" do
      project1 = TM::Project.new("Grades")
      task = TM::Task.new("Create gradebook", project1.id, 1)
      expect(task.priority).to eq(1)
    end

    it "Creates a task that has it's own id number" do
      project1 = TM::Project.new("Grades")
      task = TM::Task.new("Create gradebook", project1.id, 1)
      expect(task.task_id).to eq(4)
    end
  end
end
