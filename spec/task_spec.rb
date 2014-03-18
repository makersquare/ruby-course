require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "A new task can be created with a project id, description, priority number, and task id" do
     projectid = TM::Project.id
     newtask = TM::Task.new(projectid,"teach ruby", 3, 5)
     expect(projectid).to eq (1)
     expect(newtask.description).to eq "teach ruby"
     expect(newtask.priority).to eq 3
     expect(newtask.taskid). to eq 5
  end

  xit "Add task" do
     projectid = TM::Project.id
     newtask = TM::Task.new(projectid,"teach ruby", 3, 5)
     tasks = TM::Task.add(newtask)
     expect(TM::Task.tasklist.count).to eq (1)

     secondtask = TM::Task.new(projectid,"learn javaScript", 4, 6)
     tasks_more = TM::Task.add(secondtask)
     expect(TM::Task.tasklist.count).to eq (2)

  end

  xit "task can be marked as complete, specified by id"  do
     projectid = TM::Project.id
     newtask = TM::Task.new(projectid,"teach ruby", 3, 5)
     tasks = TM::Task.add(newtask)
     expect(TM::Task.tasklist.count).to eq (1)

     secondtask = TM::Task.new(projectid,"learn javaScript", 4, 6)
     tasks_more = TM::Task.add(secondtask)
     expect(TM::Task.tasklist.count).to eq (2)

     task_finished = TM::Task.tasklist.add

     # taskdone = taskcompleted(5)
     # expect(taskdone.status).to eq "completed"

     # method called taskcomplete

  end

  it ""

end


