require 'spec_helper'
require 'pry-debugger'


describe 'Project' do

  before (:each) do
    TM::Project.reset_Class_variable
    @project1 = TM::Project.new("NYC Project")
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end
  it "has initial project name" do
   TM::Project.project_id_counter = 1
    @project1.name.should == "NYC Project"
    @project1.id.should == 1
  end
  it "has initial unique id" do

    TM::Project.project_id_counter = 1
    @project1.id.should == 1
  end

  it "should create new task" do
    @project1.create_new_task("Web App", 5)
    expect(@project1.tasks.count).to eq(1)
    @project1.create_new_task("Guess Game", 4)
    @project1.tasks.count.should == 2
  end

   it "a task can be completed by calling upon its task id" do
  TM::Task.project_id_counter = 1
  task1 = @project1.create_new_task("Web-App", 5)
  expect(task1.status).to eq("incomplete")
  @project1.complete_task(1)
  task1.status.should == "complete"
  end

  it "has array of completed tasks sorted by creation date" do
    TM::Task.project_id_counter = 1
    Time.stub(:now).and_return(Time.parse("4pm"))
    task1 = @project1.create_new_task("Web App", 5)
    Time.stub(:now).and_return(Time.parse("3pm"))
    task2 = @project1.create_new_task("Guess Game", 4)
    Time.stub(:now).and_return(Time.parse("5pm"))
    task3 = @project1.create_new_task("Tic-Tac", 3)
    @project1.complete_task(1)
    @project1.complete_task(2)
    @project1.complete_task(3)
    @project1.completed_tasks.should == [task2, task1, task3]
  end


  it "has array of incomplete tasks sorted by priority" do
    TM::Task.project_id_counter = 1
    Time.stub(:now).and_return(Time.parse("3pm"))
    task1 = @project1.create_new_task("Web App", 5)
    Time.stub(:now).and_return(Time.parse("4pm"))
    task2 = @project1.create_new_task("Guess Game", 4)
    Time.stub(:now).and_return(Time.parse("5pm"))
    task3 = @project1.create_new_task("Tic-Tac", 3)
    @project1.incomplete_tasks.should == [task1, task2, task3]
  end
end

