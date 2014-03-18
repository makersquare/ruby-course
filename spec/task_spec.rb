require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "can be created with a project id, description, and priority number" do
    test = TM::Project.new("Test")
    test_task = TM::Task.new("TestTask", 3, TM::Project.id)

    expect(test_task.project_id).to eq(TM::Project.id)
  end

  it "a task can be marked as complete, by id" do
    test = TM::Project.new("Test")
    test_task = TM::Task.new("TestTask", 3, TM::Project.id)

    expect(test_task.task_completion).to eq([test_task.project_id, "no"])
    expect(test_task.complete).to eq([test_task.project_id, "yes"])
  end
end
