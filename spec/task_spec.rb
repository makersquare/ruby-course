require 'spec_helper'

describe 'Task' do
  let(:klass      ) { TM::Task }
  let(:project_id ) { 1 }
  let(:description) { 'My Task' }
  let(:priority   ) { 1 }
  let(:task       ) { klass.new(description, priority, project_id) }

  it "exists" do
    expect(klass).to be_a(Class)
  end

  it "can be created with a project_id, description, and priority" do
    expect(task.description).to eq(description)
    expect(task.priority).to eq(priority)
    expect(task.project_id).to eq(project_id)
  end

  it "can be set to :complete by ID" do
    task.complete
    expect(task.complete?).to eq(true)
  end
end
