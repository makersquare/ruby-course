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
      project2 = TM::Project.new('Unoriginally Named Project')
      expect(project1.id).to_not eq project2.id
    end
  end

  describe '.add_task' do
    let (:project) {
      my_project = Project.new('Some Project')
      my_project.add_task(task1)
      my_project.add_task(task2)
    }

    let (:task1) { task1 = Task.new(my_project.id, 'do some stuff', 1) }
    let (:task2) { task2 = Task.new(my_project.id, 'do other stuff', 2) }

    it "stores a list of task objects" do
      my_project.add_task(task1)
      my_project.add_task(task2)
      expect(my_project.tasks).to eq [task1, task2]
    end

    it "has a timestamp of when it is created" do
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-29 12:00PM"))
      fresh_task = Task.new(my_project.id, 'do stuff NOW', 3)
      expect(fresh_task.timestamp).to eq (Time.parse("2014-04-29 12:00PM"))
    end
  end

  describe '.completed_tasks' do
    it "retrieves a list of all completed tasks, sorted by creation date" do

    end

    it "retrieves a list of all incomplete tasks, sorted by priority" do
    end

    it "knows older tasks get priority over newer ones with the same priority" do
    end
  end

end
