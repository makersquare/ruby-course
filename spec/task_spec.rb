require 'spec_helper'

describe 'Task' do

  let(:myproject) { project = TM::Project.new('MyProject') }
  let(:task1) { task1 = TM::Task.new(project_id, 'take out the trash', 1) }
  let(:task2) { task2 = TM::Task.new(project_id, 'clean up your room', 2) }

  describe '.initialize' do
    it "should have a unique id" do
      expect(task1.id).to_not eq task2.id
    end

    it "should have a description string" do
      expect(trash_task.description).to eq 'take out the trash'
    end

    it "should have a priority from 1 to 3" do
      expect(task.priority).to be_within(2).of(3)
      expect(task.priority).to be_within(1).of(3)
    end
  end

  describe '.mark_complete' do

    it "can be marked as complete, returning true if successful" do
      expect(task1.mark_complete).to eq true
      expect(task1.status).to eq 'complete'
    end

    it "shouldn't mark completed tasks as complete, returning nil" do
      task1.mark_complete
      expect(task1.mark_complete).to eq nil
      expect(task1.status).to eq 'complete'
    end
  end
end
