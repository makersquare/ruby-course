require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  let(:task) {TM::Task.new("Design a wireframe", 5, 1)}

  describe '#initialize' do
    it "is a Task" do
      expect(task).to be_a(TM::Task)
    end
    it "create a task id" do
      expect(task.task_id).to eq(1)
    end
    it "has a description" do
      expect(task.description).to eq("Design a wireframe")
    end
    it "has a priority number" do
      expect(task.priority).to eq(5)
    end
    it "has a default complete status of 'false'" do
      expect(task.complete).to eq(false)
    end
    it "has a creation date" do
      expect(task.creation_time).not_to eq(nil)
    end
  end

end
