require 'spec_helper'
require 'pry-debugger'

describe 'Project' do

  before(:each) do
    TM::Project.reset_class_vars
    TM::Task.reset_class_vars
    @my_project = TM::Project.new('Project Mayhem')
    @p2 = TM::Project.new('Orderly Project')
    @task1 = TM::Task.new(@my_project.id, 'do some stuff', 1)
    @task2 = TM::Task.new(@my_project.id, 'do other stuff', 2)
    @my_project.add_task(@task1)
    @my_project.add_task(@task2)
    TM::Task.mark_complete(@task1.id)
  end

  describe 'self.projects' do
    it "knows about all created projects" do
      TM::Project.reset_class_vars
      test_project = TM::Project.new('testproject')
      test_project2 = TM::Project.new('testproject2')
      expect(TM::Project.projects).to eq [test_project, test_project2]
    end
  end

  describe 'self.find_project_by_id' do
    it "finds a project given a project id" do
      project = TM::Project.new('Project Mayhem')
      expect(TM::Project.find_project_by_id(1)).to eq(@my_project)
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

  describe '.completed' do
    it "returns the most recently completed tasks first" do
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-29"))
      task3 = TM::Task.new(@my_project.id, "created yesterday", 1)
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-30"))
      task4 = TM::Task.new(@my_project.id, "created today", 1)
      @my_project.tasks = []
      TM::Task.mark_complete(task3.id)
      TM::Task.mark_complete(task4.id)
      @my_project.add_task(task3)
      @my_project.add_task(task4)

      expect(@my_project.completed).to eq([task4, task3])
    end
  end

  describe '.incomplete' do
    it "returns incomplete tasks, sorted by priority (1 = highest)" do
      expect(@my_project.incomplete).to eq [@task2]

      task3 = TM::Task.new(@my_project.id, 1, "URGENT")
      task4 = TM::Task.new(@my_project.id, 2, "sorta URGent...")
      task5 = TM::Task.new(@my_project.id, 3, "meh.")
      @my_project.tasks = []
      @my_project.add_task(task4)
      @my_project.add_task(task5)
      @my_project.add_task(task3)

      expect(@my_project.incomplete).to eq([task3, task4, task5])
    end

    it 'knows if two tasks have the same priority number, the older task gets priority' do
      @my_project.tasks = []
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-29"))
      task3 = TM::Task.new(@my_project.id, "created yesterday", 2)
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-30"))
      task4 = TM::Task.new(@my_project.id, "created today", 2)

      @my_project.add_task(task4)
      @my_project.add_task(task3)
      expect(@my_project.incomplete).to eq([task3, task4])
    end
  end
end
