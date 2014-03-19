require 'spec_helper'

describe 'Project' do
  it "Project exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "Project should start with a unique id of 100001" do

    newproject = TM::Project.new("BigBank1")
    expect(newproject.uniqueId).to eq(100001)
  end

  it "Project 2 should have a unique id of 100002" do

    newproject = TM::Project.new("BigBank2")
    expect(newproject.uniqueId).to eq(100002)
  end

  it "Should be able to make a new task from Project and see its ID" do
    newproject = TM::Project.new("BigBank2")
    newproject.addTask("first task")

    expect(newproject.taskArray[0].uniqueTaskId).to eq(0)
  end

  it "Should be able to access TASKS by its Unique ID through the Task Array" do
    newproject2 = TM::Project.new("BigBank2")
    newproject2.addTask("first task")
    newproject2.addTask("second task")
    newproject2.addTask("third task")


    expect(newproject2.taskArray[0].uniqueTaskId).to eq(0)
    expect(newproject2.taskArray[1].uniqueTaskId).to eq(1)
    expect(newproject2.taskArray[2].uniqueTaskId).to eq(2)

    newproject2.changeStatus(0, "finished")
    expect(newproject2.taskArray[0].status).to eq("finished")


    puts newproject2.sortTasksbyTime(newproject2.taskArray)

  end

  it "Should sort by priority." do
    newproject3 = TM::Project.new("BigBank2")
    newproject3.addTask("first task", "that description", 1)
    newproject3.addTask("second task", "that description", 30)
    newproject3.addTask("third task", "that description", 1)
    newproject3.addTask("fourth task", "that description", 40)

    expect(newproject3.sortTasksbyPriority(newproject3.taskArray)).to eq(newproject3.taskArray)
  end

end
