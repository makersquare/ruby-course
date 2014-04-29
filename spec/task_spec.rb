require 'spec_helper'

#allow(Time).to receive(:now).and_return(Time.parse("3PM"))

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

  context 'a task is completed' do
    let(:task) { TM::Task.new(1, 1, "complete this task manager") }

    it "has an initial status of completed" do
      expect(task.completed).to eq(false)
    end

    it "changes it's status of complete to true" do
      task.complete
      expect(task.completed).to eq(true)
    end
  end
end
