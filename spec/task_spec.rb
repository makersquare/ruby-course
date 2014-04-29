require 'spec_helper'

describe 'Task' do
  before(:each) do
    reset_class_variables(TM::Task)
  end

  let(:task) { TM::Task.new(0, "A new task", 1) }

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '.initialize' do
    it "requires a description, project_id and priority_number" do
      expect { TM::Task.new }.to raise_error(ArgumentError)
      expect { task }.not_to raise_error
    end
  end

  describe '#mark_complete' do
    it "marks a task complete" do
      expect(task.complete?).to eq(false)
      expect(TM::Task.mark_complete(task.id)).to eq(true)
      expect(task.complete?).to eq(true)
    end
  end

  describe '.tasks' do
    it 'returns an array of all the projects created' do
      task
      task2 = TM::Task.new(0, "another task", 2)
      task3 = TM::Task.new(0, "is this a task?", 2)
      expect(TM::Task.tasks).to eq({task.id => task, task2.id => task2, task3.id => task3})
    end
  end

  describe '.add_task' do
    it 'adds a task to @@tasks' do
      task = double("task")
      allow(task).to receive(:id).and_return(0)

      expect(TM::Task.tasks).to eq({})
      TM::Task.add_task(task)
      expect(TM::Task.tasks).to eq({task.id => task})
    end
  end
end
