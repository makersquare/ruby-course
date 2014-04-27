require 'spec_helper'

describe 'Task' do

  let(:task) { TM::Task.new("A new task", 0, 1) }

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
      expect(task.mark_complete).to eq(true)
      expect(task.complete?).to eq(true)
    end
  end
end
