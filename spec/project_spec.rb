require 'spec_helper'

describe 'Project' do

  before(:each) do # has these happen so I don't keep writing them in
    TM::Project.reset_class_variables
    @project_1 = TM::Project.new("p 1")
    @project_2 = TM::Project.new("p 2")
    @task_2 = TM::Task.new(@project_1.id, "task 1", 2)
    @task_1 = TM::Task.new(@project_1.id, "task 2", 3)
    @project_1.add_task(@task_1)
    @project_1.add_task(@task_2)
    TM::Task.mark_complete(@task_1.id)
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes with a name" do
    expect(@project_1).to be_a(TM::Project)
    expect(@project_1.name).to eq("p1")
  end

  it "initializes with a unique id" do
    expect(@project_1.id).to eq(1)
    expect(@project_2.id).to eq(2)
  end


  it "returns a list of all completed tasks, by date" do
     allow(Time).to receive(:now).and_return(Time.parse("2014-04-30"))
      task_3 = TM::Task.new(@project_1.id, "task 3", 1)
      allow(Time).to receive(:now).and_return(Time.parse("2014-05-01"))
      task_4 = TM::Task.new(@project_1.id, "task 4", 1)
      @project_1.tasks = []
      TM::Task.mark_complete(task_3.id)
      TM::Task.mark_complete(task_4.id)
      @project_1.add_task(task_3)
      @project_1.add_task(task_4)

      expect(@project_1.completed).to eq([task_4, task_3])
    end
  end

  it "returns a list of all incomplete tasks" do
    cexpect(project_1.incomplete).to eq [@task_2]
      task_3 = TM::Task.new(@project_1.id, 1, "Must do")
      task_4 = TM::Task.new(@project_1.id, 2, "Should do")
      task_5 = TM::Task.new(@project_1.id, 3, "Can do")
      @project_1.tasks = []
      @project_1.add_task(task_3)
      @project_1.add_task(task_4)
      @project_1.add_task(task_5)

      expect(@my_project.incomplete).to eq([task_3, task_4, task_5])
  end


  it 'knows if two tasks have the same priority number, the older task gets priority' do
      @project_1.tasks = []
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-29"))
      task_3 = TM::Task.new(@project_1.id, "created yesterday", 2)
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-30"))
      task_4 = TM::Task.new(@project_1.id, "created today", 2)

      @project_1.add_task(task_4)
      @project_1.add_task(task_3)
      expect(@project_1.incomplete).to eq([task_3, task_4])
  end


