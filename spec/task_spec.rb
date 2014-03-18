require 'spec_helper'
require './lib/task-manager/task.rb'

describe 'Task' do
  before do
    @new_task = TM::Task.new(1, "write awesome code", 4)
  end


  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "initializes with a counter generated 'task' id" do
    result = @new_task.task_id
    expect(result).to eq(2)
  end

  it "is initialized with a task description" do
    result = @new_task.description
    expect(result).to eq("write awesome code")
  end

  it "is initialized with a project id" do
    result = @new_task
    expect(result.project_id).to eq(1)
  end

  it "is initialized with a priority" do
    result = @new_task
    expect(result.priority).to eq(4)
  end

  it "has a status variable that is automatically set to incomplete" do
    result = @new_task
    expect(result.status).to eq("incomplete")
  end

end
