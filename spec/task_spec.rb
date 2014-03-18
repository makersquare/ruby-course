require 'spec_helper'
require './lib/task-manager/task.rb'

describe 'Task' do

  before do
    @new_task = TM::Task.new("New Task Name", "task description goes here")
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "initializes and has a task name" do
    result = @new_task.name
    expect(result).to eq("New Task Name")
  end

  it "initializes and has a task id" do
    result = @new_task.task_id
    expect(result).to eq(3)
  end

  it "initializes with a task description" do
    result = @new_task.description
    expect(result).to eq("task description goes here")
  end

end
