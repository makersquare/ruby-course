require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "Can create a new task with id, description and priority number" do
    task = TM::Task.new(10,"Description",1)
    expect(task.project_id).to eq(10)
    expect(task.description).to eq("Description")
    expect(task.priority).to eq(1)
  end


end
