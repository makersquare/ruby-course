require 'spec_helper'

# class DB now replaces ProjectList
# this spec uses the singleton version of DB

describe 'DB' do
  before do
    @db = TM::DB.instance
  end

  describe '.initialize' do
    it "defaults the Project List with an empty projects hash" do
      expect(@db.projects).to eq({})
    end
  end

  it "can create a project and add it to the projects hash" do

    result = @db.create_project("The Best Project")
    projects_hash = @db.projects

    expect(projects_hash[1]).to be_a(TM::Project)
    # expect the return value to be the created project
    expect(result).to be_a(TM::Project)
  end

  it "can add a task to a project given project id, task priority, and task description" do
    # will uncomment this if want proj id to definitely equal 1
    # expect(TM::Project).to receive(:gen_id).and_return(1)

    project_1 = @db.create_project("The Best Project")
    # binding.pry
    added_task = @db.add_task_to_proj(project_1.id, "Eat Tacos", 3)
    # project_1 = @db.projects.first
    # puts project_1.id
    project_1_tasks = project_1.tasks

    # project_1_task_1 = project_1.tasks.first
    # removing because projects will no longer keep task data
    # expect(project_1_tasks.size).to eq(1)
    # expect(project_1_task_1.description).to eq("Eat Tacos")

    expect(@db.tasks[1]).to eq(added_task)
    expect(@db.tasks[1].description).to eq("Eat Tacos")

    # expec the add task method to return the added task
    expect(added_task.description).to eq("Eat Tacos")
    expect(added_task.priority).to eq(3)
  end

  it "can show remaining tasks for a project given PID" do
    proj_1 = @db.create_project("The Best Project")
    @db.add_task_to_proj(proj_1.id, "Eat Tacos", 3)

    tasks_remaining = @db.show_proj_tasks_remaining(proj_1.id)

    # This was a bad test because it did not fail when I refactored
    # expect(tasks_remaining).to eq(proj_1.list_incomplete_tasks)

    expect(tasks_remaining).to be_a(Array)
    expect(tasks_remaining.size).to be(1)
    expect(tasks_remaining.first.description).to eq("Eat Tacos")
  end

  it "can show completed tasks for a project given PID" do
    proj_1 = @db.create_project("The Best Project")
    added_task = @db.add_task_to_proj(proj_1.id, "Eat Tacos", 3)

    tasks_complete = @db.show_proj_tasks_complete(proj_1.id)

    # This was a bad test because it did not fail when I refactored
    # expect(tasks_remaining).to eq(proj_1.list_incomplete_tasks)
    # expect(tasks_complete).to eq(proj_1.list_completed_tasks)

    @db.mark_task_as_complete(added_task.id)
    tasks_complete = @db.show_proj_tasks_complete(proj_1.id)

    expect(tasks_complete).to be_a(Array)
    expect(tasks_complete.size).to be(1)
    expect(tasks_complete.first.description).to eq("Eat Tacos")
  end

  it "can mark a task as completed based on its id" do
    proj_1 = @db.create_project("The Best Project")
    added_task = @db.add_task_to_proj(proj_1.id, "Eat Tacos", 3)
    task_id = added_task.id

    completed_task = @db.mark_task_as_complete(task_id)

    expect(completed_task).to be_a(TM::Task)
    expect(completed_task.completed).to eq(true)
  end
end