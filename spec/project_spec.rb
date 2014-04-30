require 'spec_helper'

describe 'Project' do

  before(:each) do
      @my_project = TM::Project.new('Project Mayhem')
      @p2 = TM::Project.new('Orderly Project')
      @task1 = TM::Task.new(@my_project.id, 'do some stuff', 1)
      @task2 = TM::Task.new(@my_project.id, 'do other stuff', 2)
      @my_project.add_task(@task1)
      @my_project.add_task(@task2)
      @task1.mark_complete(@task1.id)
  end

  describe 'self.projects' do
    it "knows about all created projects" do
      TM::Project.projects = []
      test_project = TM::Project.new('Project Runway')
      test_project2 = TM::Project.new('Project Runway2')
      expect(TM::Project.projects).to eq [test_project, test_project2]
    end
  end

  describe '.initialize' do
    it "should be created with a name" do
      expect(@my_project.name).to eq "Project Mayhem"
      expect { TM::Project.new() }.to raise_error
    end

    it "must have a unique id" do
      expect(@my_project.id).not_to eq @p2.id
    end
  end

  describe '.get_tasks_by_status' do
    it "stores task objects in an array" do
      expect(@my_project.tasks).to eq [@task1, @task2]
      expect(@my_project.tasks.size).to eq 2
    end

    it "returns the most recently completed tasks first" do
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-29"))
      task3 = TM::Task.new(@my_project.id, "created yesterday", 1)
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-30"))
      task4 = TM::Task.new(@my_project.id, "created today", 1)
      @my_project.tasks = []
      task3.mark_complete(task3.id)
      task4.mark_complete(task4.id)
      @my_project.add_task(task3)
      @my_project.add_task(task4)
      expect(@my_project.get_tasks_by_status('complete')).to eq([task4, task3])
    end

    it "returns incomplete tasks, sorted by priority (1 = highest)" do
      expect(@my_project.get_tasks_by_status('incomplete')).to eq [@task2]
      task3 = TM::Task.new(@my_project.id, "URGENT", 3)
      task4 = TM::Task.new(@my_project.id, "sorta URGent...", 2)
      task5 = TM::Task.new(@my_project.id, "meh.", 1)
      @my_project.tasks = []
      # add in unsorted fashion
      @my_project.add_task(task4)
      @my_project.add_task(task5)
      @my_project.add_task(task3)
      expect(@my_project.get_tasks_by_status('incomplete')).to eq([task5, task4, task3])
    end

    it 'knows if two tasks have the same priority number, the older task gets priority' do
      @my_project.tasks = []
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-29"))
      task3 = TM::Task.new(@my_project.id, "created yesterday", 2)
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-30"))
      task4 = TM::Task.new(@my_project.id, "created today", 2)
      @my_project.add_task(task4)
      @my_project.add_task(task3)
      expect(@my_project.get_tasks_by_status('incomplete')).to eq([task3, task4])
    end
  end
end
