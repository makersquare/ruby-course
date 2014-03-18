require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "is initialized with a project id, description and priority number" do
  	task = TM::Task.new(1, "cook pasta", 3)
  	expect(task.project_id).to eq(1)
  	expect(task.description).to eq 'cook pasta'
  	expect(task.priority).to eq(3)
  end

  it "can be marked as complete" do
  	task = TM::Task.new(1, "cook pasta", 3)
  	expect(task.status).to eq 'incomplete'

  	task.mark_complete
  	expect(task.status).to eq 'complete'
  end
end
