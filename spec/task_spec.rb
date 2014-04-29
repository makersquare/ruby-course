require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "allows task to be created with project id, description, and priority number" do
    task = TM::Task.new(123,"hello",1)
    expect(task.project_id).to eq(123)
    expect(task.description).to eq("hello")
    expect(task.priority_number).to eq(1)
  end
end
