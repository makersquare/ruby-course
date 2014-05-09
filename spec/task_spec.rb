require 'spec_helper'
require 'pry-debugger'

describe 'Task' do
  before do
    @project = TM::Project.new("project")
    @task = TM::Task.new(@project.pid, "description1", 3, "2014-05-08")

  end

  it "inializes with a project id, description, priority number and due_date" do
    expect(@task.project_id).to eq (@project.pid)
    expect(@task.description).to eq ("description1")
    expect(@task.priority).to eq 3
    expect(@task.due_date).to eq (Date.parse("2014-05-08"))
  end

  it "marks tasks as complete" do
    expect(@task.status).to eq 0
    TM::Task.complete_task(@task.task_id)

    expect(@task.status).to eq 1
  end

  it "marks overdue tasks as overdue" do
    # Stub today as a date in the future so this test can pass
    @today = Date.parse("2015-05-08")
    Date.stub(:today).and_return(@today)
    TM::Task.mark_overdue
    expect(@task.overdue).to eq 1
  end

  it "allows tasks to have tags" do
    task1 = TM::Task.new(@project.pid, "description1", 10, "2014-05-08",{tags: ["tag1","tag2","tag3"]})
    expect(task1.tags).to include ("tag1")
  end

  it "allows tasks to be marked as recurring, daily or weekly" do
    # Task repeats daily
    task1 = TM::Task.new(@project.pid, "description1", 10, "2014-05-08",{tags: ["tag1","tag2","tag3"], recurring: 1})
    # Task repeats weekly
    task2 = TM::Task.new(@project.pid, "description1", 10, "2014-05-08",{tags: ["tag1","tag2","tag3"], recurring: 2})
    task3 = TM::Task.new(@project.pid, "description1", 10, "2014-05-08",{tags: ["tag1","tag2","tag3"]})

    expect(task1.frequency).to eq 'daily'
    expect(task2.frequency).to eq 'weekly'
  end

  it "creates a new copy of daily recurring tasks each day" do
    task1 = TM::Task.new(@project.pid, "description1", 10, "2014-05-08",{tags: ["tag1","tag2","tag3"], recurring: 1})
    task2 = TM::Task.new(@project.pid, "description1", 10, "2014-05-08",{tags: ["tag1","tag2","tag3"], recurring: 1})

    # Before repeated tasks, @project should have 3 tasks
    expect(@project.tasks.length).to eq 3
    @time = Time.parse("2014-05-09 23:23:23")
    Time.stub(:now).and_return(@time)

    TM::Task.repeat_tasks
    # After repeated tasks, @project should have 4 tasks
    expect(@project.tasks.length).to eq 5
  end

  it "creates a new copy of weekly recurring tasks each week" do
    task1 = TM::Task.new(@project.pid, "description1", 10, "2014-05-08",{tags: ["tag1","tag2","tag3"], recurring: 2})
    task2 = TM::Task.new(@project.pid, "description1", 10, "2014-05-08",{tags: ["tag1","tag2","tag3"], recurring: 2})

    # Before repeated tasks, @project should have 3 tasks
    expect(@project.tasks.length).to eq 3
    @time = Time.parse("2014-05-16 23:23:23")
    Time.stub(:now).and_return(@time)

    TM::Task.repeat_tasks
    # After repeated tasks, @project should have 4 tasks
    expect(@project.tasks.length).to eq 5
  end
end
