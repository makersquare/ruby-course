require 'spec_helper'

describe TM::Database do
  before do
    @db = TM::Database.new
  end

  describe '.initialize' do
    it "starts with no projects" do
      expect(@db.all_projects).to eq([])
    end
  end

  it "creates a project" do
    project = @db.create_project("The Best Project")
    all_projects = @db.all_projects

    expect(all_projects.count).to eq(1)
    expect(all_projects.first.id).to eq(project.id)
    expect(all_projects.first.name).to eq(project.name)
  end

  context "A project with one task" do
    before do
      @project = @db.create_project("Learn Shortcuts")
      @task = @db.add_task_to_proj(@project.id, "Watch Screencasts", 2)
    end

    it "can creates a task and adds it to a project" do
      expect(@task.proj_id).to eq(@project.id)
      # Ensure task is stored in db
      retrieved_task = @db.get_task(@task.id)
      expect(retrieved_task.description).to eq "Watch Screencasts"
    end

    it "can show remaining tasks for a project given PID, sorted by priority" do
      task_2 = @db.add_task_to_proj(@project.id, "Second", 0)
      tasks_remaining = @db.show_proj_tasks_remaining(@project.id)

      expect(tasks_remaining.count).to eq(2)
      expect(tasks_remaining.first.id).to eq(task_2.id)
      expect(tasks_remaining.last.id).to eq(@task.id)
    end
  end
end