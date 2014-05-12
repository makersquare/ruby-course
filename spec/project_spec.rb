require 'spec_helper'
require 'pry-debugger'

describe 'Project' do
  let(:db) { TM.database }
  before (:each) do
    TM::Project.reset_class_variables
    TM::Task.reset_class_variables
    @project = db.create_project( {name: "project", id: db.project_count, project_tasks: {} } )
    @project1 = db.create_project( {name: "project 1", id: db.project_count, project_tasks: {} } )
    @task = db.create_task( {task_id: db.task_count, project_id: @project.pid, desc: "description1", priority: 3, due_date: "2014-05-08" , completed_at: nil, status: 0, created_at: Time.now} )
    @task1 = db.create_task( {task_id: db.task_count, project_id: @project.pid, desc: "description1", priority: 10, due_date: "2014-05-08", completed_at: nil, status: 0, created_at: Time.now + 100} )
    @task2 = db.create_task( {task_id: db.task_count, project_id: @project.pid, desc: "description1", priority: 5, due_date: "2016-05-08", completed_at: nil, status: 0, created_at: Time.now + 200} )
  end

  it "initializes with a unique project id and name" do
    expect(@project.pid).to eq 0
    expect(@project.name).to eq "project"
    expect(@project1.pid).to eq 1
    expect(@project1.name).to eq "project 1"
  end

  it "adds new tasks to a Project array" do
    expect(db.projects[@project.pid][:project_tasks].length).to eq 3
    project = db.show_project(@project.pid)
    expect(@project.project_tasks.length).to eq 3
  end

  it "retrieves completed tasks and sorts them by creation date" do
    @task.complete_task(@task.task_id)
    @task1.complete_task(@task1.task_id)
    @task2.complete_task(@task2.task_id)

    expect(@project.completed_tasks.length).to eq 3
    # Should return task objects, not data
    expect(@project.completed_tasks.first).to be_a(TM::Task)
  end

  it "retrieves incomplete tasks and sorts them by priority" do
    @task.complete_task(@task.task_id)

    expect(@project.incomplete_tasks.first.task_id).to eq 1
    expect(@project.incomplete_tasks.last.task_id).to eq 2
  end

  # Extension tests, leave pending until basic functionality is restored with DB

  xit "retrieves and sorts overdue tasks" do
    # Stub today as a date in the future so this test can pass
    @today = Date.parse("2015-05-08")
    Date.stub(:today).and_return(@today)
    TM::Task.mark_overdue

    # Two before tasks are overdue, one is not
    expect(@project.overdue_tasks.length).to eq 2

    # First two tasks returned by incomplete tasks should be overdue, last task should not be overdue
    expect(@project.incomplete_tasks.first.task_id).to eq 2
    expect(@project.incomplete_tasks.last.task_id).to eq 3
  end

  xit "calculates percentage completion of all tasks in project" do
    @today = Date.parse("2015-05-08")
    Date.stub(:today).and_return(@today)
    TM::Task.mark_overdue
    @project.completion = @project.project_completion_percent

    expect(@project.completion).to eq 0.33
    end

  xit "searches tags and returns matching tasks" do
    task3 = TM::Task.new(@project.pid, "description1", 10, "2014-05-08",{tags: ["tag1","tag8","tag9"]})
    task4 = TM::Task.new(@project.pid, "description1", 10, "2014-05-08",{tags: ["tag4","tag2","tag3"]})
    task5 = TM::Task.new(@project.pid, "description1", 10, "2014-05-08",{tags: ["tag4","tag2","tag3"]})

    # It should find one tag if only one matches search
    expect(@project.search("tag1").first).to eq task3

    # It should find more than one if more than one matches
    expect(@project.search("tag3").first).to eq task4
    expect(@project.search("tag3").length).to eq 2

  end

end
