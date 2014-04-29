require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  context 'a new task is initialized' do
    let(:project) { TM::Project.new('my_project.rb') }
    let(:task) { TM::Task.new(1, 1, "complete this task manager") }

    it 'creates a new task with a projectID' do
      expect(task.project_id).to eq(1)
    end

    it 'creates a new task with a description' do
      expect(task.description).to eq("complete this task manager")
    end

    it 'creates a new task with a priority' do
      expect(task.priority).to eq(1)
    end
  end
end
