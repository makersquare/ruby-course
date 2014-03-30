require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "Can create a new task with id, description and priority number, and project id" do
    TM::Task.class_variable_set :@@task_count, 0
    task = TM::Task.new("Description",1,2)
    expect(task.task_id).to eq(1)
    expect(task.description).to eq("Description")
    expect(task.priority).to eq(1)
  end
end
