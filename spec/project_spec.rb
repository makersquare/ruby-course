require 'spec_helper'

describe 'Project' do

  describe '.initialize' do
    it "should be created with a name" do
      project = TM::Project.new('Project Mayhem')
      expect(project.name).to eq "Project Mayhem"
      expect { TM::Project.new() }.to raise_error
    end

    it "must have a unique id" do
      project1 = TM::Project.new('Unoriginally Named Project')
      project2 = TM::Project.new('Another Unoriginally Named Project')
      expect(project1.id).not_to eq project2.id
    end
  end

  describe '.add_task' do

    it "stores task objects in an array" do
      my_project = TM::Project.new('some project')
      task1 = TM::Task.new(my_project.id, 'do some stuff', 1)
      task2 = TM::Task.new(my_project.id, 'do other stuff', 2)
      my_project.add_task(task1)
      my_project.add_task(task2)
      expect(my_project.tasks.size).to eq 2
      expect(my_project.tasks).to eq [task1, task2]
    end
  end

  describe '.completed_tasks' do
    it "retrieves a list of all completed tasks, sorted by creation date" do
      my_project = TM::Project.new('some project')
      task1 = TM::Task.new(my_project.id, 'do some stuff', 1)
      task2 = TM::Task.new(my_project.id, 'do other stuff', 2)
      my_project.add_task(task1)
      my_project.add_task(task2)



      expect(my_project.completed_tasks.size).to eq 1
    end

    it "retrieves a list of all incomplete tasks, sorted by priority" do
    end

    it "knows older tasks get priority over newer ones with the same priority" do
    end
  end

end
