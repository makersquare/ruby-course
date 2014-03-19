require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  before do
   @newproject = TM::Project.new("MakerSquare", 1)
   @projectid = @newproject.projectid
   @newtask = TM::Task.new(@projectid,"teach ruby", 3, 5)
   @secondtask = TM::Task.new(2,"teach ruby", 3, 5,)

  end

  it "A new task can be created with a project id, description, priority number, and task id" do

     expect(@newtask.projectid).to eq 1
     expect(@newtask.description).to eq "teach ruby"
     expect(@newtask.priority).to eq 3
     expect(@newtask.taskid). to eq 5
     Time.stub(:now).and_return(@creationtime)

  end

  it "A task can be marked as complete, specified by id"  do
     # task method done, on objct task, change to completed
    @newproject.add_task_to_project(@newtask)
    taskchange = @newtask.done(@newproject.tasklist,@newtask)
    expect(taskchange).to eq "completed"
     # you already have an array of tasks

     # expect(taskdone.status).to eq "completed"

     # method called taskcomplete

  end

  it "Tells the creations date" do
      @newtask.creationtime
  end

end


