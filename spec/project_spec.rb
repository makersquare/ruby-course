require 'spec_helper'

describe 'Project' do
  it "exists" do

    expect(TM::Project).to be_a(Class)
  end

  before(:each) do

    TM::Project.reset_class_variable
    @project1 = TM::Project.new("Fix-up house")
    @project2 = TM::Project.new("Go to the grocery store")
  end


  it "initializes with a project name" do

    expect(@project1.project_name).to eq("Fix-up house")
    expect(@project2.project_name).to eq("Go to the grocery store")
  end

  it "assigns a pid" do

    expect(@project1.pid).to eq 1
    expect(@project2.pid).to eq 2
  end

  it "resets class variables" do

    expect(TM::Project.reset_class_variable).to_not raise_error
  end

  # it "returns a list of completed tasks and sorts them by creation date" do



  #   expect(TM::Task.completed_tasks).to eq([@task1])
  # end

  describe "completed_tasks" do

    before(:each) do

      @task1 = TM::Task.new("Build a garden", 1, @project1.pid)
      TM::Task.add_tasks(@task1)
    end

    it "returns the completed tasks for that project" do
      expect(@project1.completed_tasks).to eq([])

      TM::Task.is_complete(1)
      @task1.complete = true
      expect(@project1.completed_tasks).to eq([@task1])
    end

    it "sorts the tasks by creation time" do

      @task1.complete = true
    end
  end

  describe "incomplete_tasks" do

    before(:each) do

      @task2 = TM::Task.new("Fix the cracks on the skirting", 2, @project1.pid)
      @task3 = TM::Task.new("Clean carport", 3, @project1.pid)
      TM::Task.add_tasks(@task2)
      TM::Task.add_tasks(@task3)
    end

    it "can retrieve a list of all incomplete tasks, sorted by priority.
    If two tasks have the same priority number, the older task gets priority" do

    expect(@project1.incomplete_tasks).to eq([@task2, @task3])

    end
  end
end
