require 'spec_helper'

describe "DB" do

  before do
    @db = TM::DB.new
    TM::Task.class_variable_set(:@@task_count, 0)
    TM::Project.class_variable_set(:@@projectcount, 0)
    TM::Employee.class_variable_set(:@@employeecount, 0)

    @project = @db.create_project("Project Name")
    @employee = @db.create_employee("Employee Name")

  end

  it "contains a hash of projects accessible by index with get_project added by create_project" do
    expect(@db.get_project(1)).to be_a(TM::Project)
    @db.create_project("Second")
    expect(@db.get_project(2)).to be_a(TM::Project)
  end

  it "can create a task and add it to a project, and add it to tasks hash" do
    new_task = @db.create_task("A fun task",5,6)
    expect(new_task).to be_a(TM::Task)
    expect(new_task.description).to eq("A fun task")
    expect(new_task.project_id).to eq(6)
    expect(new_task.priority).to eq(5)
    expect(@db.tasks[new_task.task_id]).to eq(new_task)
  end
end
