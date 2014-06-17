require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '.initialize' do
    it 'should be created with a project id, description, priority, status and creation time' do
      time = Time.now
      expect(Time).to receive(:now).and_return(time)
      task_x = TM::Task.new('task x', 10, 1)

      expect(task_x.status).to eq 'not complete'
      expect(task_x.priority).to eq 10
      expect(task_x.time_created).to eq time
      expect(task_x.description).to eq 'task x'
      expect(task_x.task_id).to eq 1
    end
  end

  describe '.complete' do
    it 'should mark a task as complete' do
      task_x = TM::Task.new('task x', 10, 1)
      task_x.complete

      expect(task_x.status).to eq 'complete'
    end
  end
end
