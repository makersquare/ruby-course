require 'spec_helper'
require './lib/task-manager/task.rb'

describe 'Task' do

  before do
    @new_task = TM::Task.new(1, "New task description", 5)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "initializes and has a project id" do
    result = @new_task
    expect(result.project_id).to eq(1)
  end

  it "initializes and has a task description" do
    result = @new_task
    expect(result.description).to eq("New task description")
  end

  it "initializes and has a task id" do
    expect(TM::Task).to receive(:gen_id).and_return(2)
    result = TM::Task.new(1, "New task description", 5)
    expect(result.id).to eq(2)
  end

  it "initializes with a priority number" do
    result = @new_task
    expect(result.priority_number).to eq(5)
  end

  it "initializes with a status" do
    result = @new_task
    expect(result.status).to eq("incomplete")
  end


end
