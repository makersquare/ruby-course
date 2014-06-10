require 'pry-debugger'
require 'spec_helper'

describe 'Task' do

  let(:task) {TM::Task.new('something to do', 1)}

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "creates a new task with a project id, description, and priority number" do
    expect(task.description).to eq('something to do')
    expect(task.priority).to eq(1)
  end

  it "can be marked as complete, specified by id" do
    task.mark_complete
    expect(task.status).to eq('complete')
  end
end
