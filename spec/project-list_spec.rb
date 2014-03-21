require 'spec_helper'

# this spec uses the singleton version of the ProjectList

describe 'ProjectList' do
  before do
    @pl = TM::ProjectList.instance
  end

  describe '.initialize' do
    it "defaults the Project List with an empty projects array" do
      expect(@pl.projects).to eq([])
    end
  end

  it "can create a project and add it to the projects array" do

    result = @pl.create_project("The Best Project")
    projects_array = @pl.projects

    expect(projects_array.first).to be_a(TM::Project)
    # expect the return value to be the created project
    expect(result).to be_a(TM::Project)
  end

  it "can add a task to a project given project id, task priority, and task description" do
    # will uncomment this if want proj id to definitely equal 1
    # expect(TM::Project).to receive(:gen_id).and_return(1)

    project_1 = @pl.create_project("The Best Project")
    added_task = @pl.add_task_to_proj(project_1.id, "Eat Tacos", 3)
    # project_1 = @pl.projects.first
    # puts project_1.id
    project_1_tasks = project_1.tasks
    project_1_task_1 = project_1.tasks.first

    expect(project_1_tasks.size).to eq(1)
    expect(project_1_task_1.description).to eq("Eat Tacos")

    # expec the add task method to return the added task
    expect(added_task.description).to eq("Eat Tacos")
    expect(added_task.priority).to eq(3)
  end

  it "can show remaining tasks for a project given PID" do
    proj_1 = @pl.create_project("The Best Project")
    @pl.add_task_to_proj(proj_1.id, "Eat Tacos", 3)

    tasks_remaining = @pl.show_proj_tasks_remaining(proj_1.id)

    expect(tasks_remaining).to eq(proj_1.list_incomplete_tasks)
  end

  it "can show completed tasks for a project given PID" do
    proj_1 = @pl.create_project("The Best Project")
    @pl.add_task_to_proj(proj_1.id, "Eat Tacos", 3)

    tasks_complete = @pl.show_proj_tasks_complete(proj_1.id)

    expect(tasks_complete).to eq(proj_1.list_completed_tasks)
  end

  it "can mark a task as completed based on its id" do
    proj_1 = @pl.create_project("The Best Project")
    @pl.add_task_to_proj(proj_1.id, "Eat Tacos", 3)
    task_id = proj_1.tasks.first.id
    completed_task = @pl.mark_task_as_complete(task_id)

    expect(completed_task).to be_a(TM::Task)
    expect(completed_task.completed).to eq(true)
  end
end