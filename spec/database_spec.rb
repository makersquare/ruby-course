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
    project_1 = @db.create_project("The Best Project")
    added_task = @db.add_task_to_proj(project_1.id, "Eat Tacos", 3)
    # project_1 = @db.projects.first
    # puts project_1.id
    project_1_tasks = project_1.tasks

    # project_1_task_1 = project_1.tasks.first
    # removing because projects will no longer keep task data
    # expect(project_1_tasks.size).to eq(1)
    # expect(project_1_task_1.description).to eq("Eat Tacos")

    expect(@db.tasks.length).to eq(1)
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

  #############################
  ## other Task CRUD Methods ##
  #############################

  describe "other Task CRUD Methods" do

    xit "can create a task" do
      ## already covered by add_task_to_proj method
    end
    # get/read
    it "can get a task" do
      proj = @db.create_project("The Best Proj")
      added_task = @db.add_task_to_proj(proj.id, "Eat Tacos", 3)
      gotten_task = @db.get_task(added_task.id)

      expect(gotten_task.description).to eq("Eat Tacos")
    end

    it "can update a task" do
      proj = @db.create_project("The Best Proj")
      added_task = @db.add_task_to_proj(proj.id, "Eat Tacos", 3)

      @db.update_task(added_task.id, "Make Smores", 1)
      expect(added_task.description).to eq("Make Smores")
      expect(added_task.priority).to eq(1)
    end

    context "if update parameters are nil or empty" do
      it "will not change these parameters" do
        proj = @db.create_project("The Best Proj")
        added_task = @db.add_task_to_proj(proj.id, "Eat Tacos", 3)

        @db.update_task(added_task.id)
        expect(added_task.description).to eq("Eat Tacos")
        expect(added_task.priority).to eq(3)
      end
    end

    it "can delete a task" do
      proj = @db.create_project("The Best Proj")
      added_task = @db.add_task_to_proj(proj.id, "Eat Tacos", 3)

      expect(@db.tasks.length).to eq(1)

      @db.delete(added_task.id)
      expect(@db.tasks[added_task.id]).to be_nil
      expect(@db.tasks.length).to eq(0)
    end
  end

  ################################
  ## other Project CRUD Methods ##
  ################################

  describe "other project CRUD methods" do

    let(:proj) { @db.create_project("The Best Proj") }

    xit "can create a project" do
      ## already covered by create_proj method
    end

    it "can get a project" do
      # proj = @db.create_project("The Best Proj")

      gotten_proj = @db.get_proj(proj.id)

      expect(gotten_proj).to be_a(TM::Project)
      expect(gotten_proj.name).to eq("The Best Proj")
    end

    it "can update a project" do
      # proj = @db.create_project("The Best Proj")

      @db.update_proj(proj.id, "Taking Over The World")
      expect(proj.name).to eq("Taking Over The World")
      expect(@db.projects[1].name).to eq("Taking Over The World")
    end

    context "if update parameters are nil or empty" do
      it "will not change these parameters" do
        # proj = @db.create_project("The Best Proj")

        @db.update_proj(proj.id, "Taking Over The World")
        expect(proj.name).to eq("Taking Over The World")
        expect(@db.projects[1].name).to eq("Taking Over The World")
      end
    end

    it "can delete a project" do
      # proj = @db.create_project("The Best Proj")

      expect(@db.projects.length).to eq(1)
      expect(@db.projects[proj.id]).to_not be_nil
      @db.delete_proj(proj.id)

      expect(@db.projects.length).to eq(0)
      expect(@db.projects[proj.id]).to be_nil
    end
  end
end