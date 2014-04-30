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

  describe '.initialize' do
    it "should be created with a name" do
      expect(@my_project.name).to eq "Project Mayhem"
      expect { TM::Project.new() }.to raise_error
    end

    it "must have a unique id" do
      expect(@my_project.id).not_to eq @p2.id
    end

    it "'s class should know about all created projects" do
      expect(Project.projects).to eq [@my_project, @p2]
    end
  end


  describe '.get_tasks_by_status' do
    it "stores task objects in an array" do
      expect(@my_project.tasks).to eq [@task1, @task2]
      expect(@my_project.tasks.size).to eq 2
    end

    it "retrieves a list of all completed tasks" do
      expect(@my_project.get_tasks_by_status('complete')).to eq [@task1]
    end

    it "returns the newest completed tasks first" do
      # allow(Time).to receive(:now).and_return(Time.parse("2014-04-29"))
      # @task3 = TM::Task.new(@my_project.id, "created yesterday", 1)

      # allow(Time).to receive(:now).and_return(Time.now)
      # @task4 = TM::Task.new(@my_project.id, "created today", 1)
      # @my_project.tasks = []
      # @my_project.add_task(@task3)
      # @my_project.add_task(@task4)
      # expect(@my_project.get_tasks_by_status('incomplete')).to eq([@task4, @task3])
    end

    it "retrieves a list of all incomplete tasks, sorted by priority" do
      expect(@my_project.get_tasks_by_status('incomplete')).to eq [@task2]
    end

    it "sorts incomplete tasks by priority" do
    end

    it "knows older tasks get priority over newer ones with the same priority" do
    end
  end

end
