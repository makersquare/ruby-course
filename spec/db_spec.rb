require 'spec_helper'

describe "DB" do

  before do
    @db = TM::DB.new
    @project = @db.create_project("Project Name")
    @employee = @db.create_employee("Employee Name")
  end

  it "contains a hash of projects accessible by index with get_project added by create_project" do
    expect(@db.get_project(0)).to be_a(TM::Project)
    @db.create_project("Second")
    expect(@db.get_project(1)).to be_a(TM::Project)
  end

  it "can create a task and add it to a project, and add it to tasks hash" do
    new_task = @db.create_task("A fun task",5,6)
    expect(new_task).to be_a(TM::Task)
    expect(new_task.description).to eq("A fun task")
    expect(new_task.project_id).to eq(6)
    expect(new_task.priority).to eq(5)
    expect(@db.tasks[new_task.task_id]).to eq(new_task)
  end

  it "can mark a task complete" do
    new_task = @db.create_task("A fun task",5,6)
    @db.mark_task_complete(new_task.task_id)
    expect(new_task.complete).to eq(true)
  end

  it "can retrieve a list of all complete tasks, sorted by creation date" do
    puts @db.create_task("task 1",5,@project.project_id).task_id
    puts @db.create_task("task 2",4,@project.project_id).task_id
    puts @db.create_task("task 3",3,@project.project_id).task_id
    puts @db.create_task("task 4",2,@project.project_id).task_id
    puts @db.create_task("task 5",1,@project.project_id).task_id

    @db.mark_task_complete(6)
    @db.mark_task_complete(3)
    @db.mark_task_complete(5)

    completed_projects = @db.complete_task_list(@project.project_id)

    expect(completed_projects[0].description).to eq("task 1")
    expect(completed_projects[1].description).to eq("task 3")
    expect(completed_projects[2].description).to eq("task 4")
    expect(completed_projects.length).to eq(3)
  end

  it "can create a list of all incomplete tasks, sorted by creation date and priority" do
    db = TM::DB.new
    project = db.create_project("new test project")

    puts db.create_task("task 1",4,project.project_id).task_id
    puts db.create_task("task 2",3,project.project_id).task_id
    puts db.create_task("task 3",1,project.project_id).task_id
    puts db.create_task("task 4",1,project.project_id).task_id
    puts db.create_task("task 5",3,project.project_id).task_id

    incomplete_projects = db.incomplete_task_list(project.project_id)
    expect(incomplete_projects[0].description).to eq("task 3")
    expect(incomplete_projects[0].description).to eq("task 4")
    expect(incomplete_projects[0].description).to eq("task 2")
    expect(incomplete_projects[0].description).to eq("task 5")
    expect(incomplete_projects[0].description).to eq("task 1")

  end
end
