require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "creates a new task" do
    # TM::Task.new(project_id,description,priority,task_id)
    TM::Task.new(1,"diet",1,1)
    expect(TM::Task.new(1,"diet",1,1).priority).to eq 1
    expect(TM::Task.new(1,"diet",1,1).task_id).to eq 1
  end


end

# A new task can be created with a project id, description, and priority number


# A task can be marked as complete, specified by id

