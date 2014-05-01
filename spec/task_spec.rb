require 'spec_helper'

describe 'Task' do

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "has initialize project id, description, priority number, and id" do
    TM::Task.project_id_counter = 1
    task = TM::Task.new(1, "Video chat application", 5)
    expect(task.project_id).to eq(1)
    expect(task.description).to eq("Video chat application")
    expect(task.priority_no).to eq(5)
    expect(task.id).to eq(1)
  end
end
