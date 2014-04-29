require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  context 'a new task is initialized' do
    let(:project) { TM::Project.new('my_project.rb') }
    let(:task) { TM::Task.new('task1', 1) }

    it 'creates a new task with a name' do
      expect(task.name).to eq("task1")
    end
  end
end
