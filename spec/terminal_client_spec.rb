require 'spec_helper'
require 'pry-debugger'

describe 'TerminalClient' do
  # before(:each) do
  #   @x = TM::TerminalClient.new
  # end

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

    TM::Task.mark_complete(task.task_id)

    TM::TerminalClient.new
  end
end
