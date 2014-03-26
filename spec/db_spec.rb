require 'spec_helper'

describe "Project List" do

  before do
    @projectlist = TM::DB.new
    @projectlist.create_project("Project Name")
    @projectlist.create_employee("Employee Name")
  end

  it "contains a hash of projects accessible by index with get_project added by create_project" do
    expect(@projectlist.get_project(0)).to be_a(TM::Project)
    @projectlist.create_project("Second")
    expect(@projectlist.get_project(1)).to be_a(TM::Project)
  end

  it "can create a task and add it to a project, and add it to tasks hash" do
    new_task = @projectlist.create_task("A fun task",5,6)
    expect(new_task).to be_a(TM::Task)
    expect(new_task.description).to eq("A fun task")
    expect(new_task.project_id).to eq(6)
    expect(new_task.priority).to eq(5)
    expect(@projectlist.tasks[new_task.task_id]).to eq(new_task)
  end

  it "can mark a task complete" do
    new_task = @projectlist.create_task("A fun task",5,6)
    @projectlist.mark_task_complete(new_task.task_id)
    expect(new_task.complete).to eq(true)
  end
end
