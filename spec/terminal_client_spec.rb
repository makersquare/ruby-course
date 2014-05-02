require 'spec_helper'
require 'pry-debugger'

describe 'TerminalClient' do
  it "exists" do
    expect(TM::TerminalClient).to be_a(Class)
  end

  it "works" do
    TM::Project.reset_class_variables
    project1 = TM::Project.new("Grades")
    project2 = TM::Project.new("Tests")
    task = TM::Task.new("Create gradebook", project1.id, 3)
    task2 = TM::Task.new("Add students", project1.id, 2)
    task3 = TM::Task.new("Add tests", project1.id, 1)

    project1.add_task(task)
    project1.add_task(task2)
    project1.add_task(task3)

    task.due_date = "1 Feb 2014"
    task2.due_date = "1 June 2014"
    task3.due_date = "3 Feb 2014"

    # TM::Task.mark_complete(task.task_id)

    TM::TerminalClient.new
  end
end
