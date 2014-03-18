require 'spec_helper'
require './lib/task-manager/task.rb'

describe 'Task' do
  before do
    @new_task = TM::Task.new("New Task", "write awesome code")
  end


  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "initializes with a task name" do
    result = @new_task.name
    expect(result).to eq("New Task")
  end

  it "initializes with a 'task' id" do
    result = @new_task.task_id
    expect(result).to eq(3)
  end

  it "has a task description" do
    result = @new_task.description
    expect(result).to eq("write awesome code")
  end

end
