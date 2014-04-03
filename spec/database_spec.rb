require 'spec_helper'

describe 'DB' do
  before do
    @db = TM.db
  end

  it "starts with zero projects and tasks" do
    expect(@db.all_projects.count).to eq 0
    expect(@db.all_tasks.count).to eq 0
  end

  it "can create a project and retrieve a project" do
    project = @db.create_project("The Best Project")

    project_2 = @db.get_project(project.id)
    expect(project_2.name).to eq "The Best Project"
  end

  it "can add a task to a project" do
    project = @db.create_project("The Best Project")
    task = @db.create_task(project.id, "Eat Tacos", 3)

    task_2 = @db.get_task(task.id)

    expect(task_2.project_id).to eq(project.id)
    expect(task_2.description).to eq("Eat Tacos")
    expect(task_2.priority).to eq(3)
  end

  it "can update a task" do
    project = @db.create_project("Update Stuff")
    task = @db.create_task(project.id, "Change Me", 3)

    @db.update_task(task.id, :description => "I changed")
    task2 = @db.get_task(task.id)
    expect(task2.description).to eq "I changed"
  end

  it "can get all tasks for a given project" do
    project = @db.create_project("Learn SQL")
    task_1 = @db.create_task(project.id, "Attend MakerSquare", 1)
    task_2 = @db.create_task(project.id, "Read Documentation", 2)
    task_3 = @db.create_task(project.id, "Experiment", 3)

    tasks = @db.get_remaining_tasks_for_project(project.id)
    expect(tasks.count).to eq 3

    descriptions = tasks.map(&:description)
    expect(descriptions).to include("Attend MakerSquare", "Read Documentation", "Experiment")
  end

  describe "Persistence" do
    it "has persistence for projects" do
      # This should save to the db
      project_1 = @db.create_project('cool stuff')
      project_2 = @db.create_project('other stuff')

      # Here we create a **new** db instance. It should have access
      # to the projects we created with the original db instance.
      other_db = TM::DB.new('tm_test.db')
      expect(other_db.all_projects.count).to eq 2

      names = other_db.all_projects.map(&:name)
      expect(names).to include('cool stuff', 'other stuff')
    end

    it "has persistence for tasks" do
      # This should save to the db
      project = @db.create_project("Testing tasks")
      task_1 = @db.create_task(project.id, "Hello", 1)
      task_2 = @db.create_task(project.id, "World", 2)

      # Here we create a **new** db instance. It should have access
      # to the projects we created with the original db instance.
      other_db = TM::DB.new('tm_test.db')
      expect(other_db.all_tasks.count).to eq 2

      descriptions = other_db.all_tasks.map(&:description)
      expect(descriptions).to include("Hello", "World")
    end
  end

end