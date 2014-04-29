require 'spec_helper'

describe 'Task' do

  let(:my_project) { project = TM::Project.new('my_project') }
  let(:task1) { task1 = TM::Task.new(my_project.id, 'take out the trash', 1) }
  let(:task2) { task2 = TM::Task.new(my_project.id, 'clean up your room', 2) }

  describe '.initialize' do
    it "has a unique id" do
      expect(task1.id).to_not eq task2.id
    end

    it "has a description string" do
      expect(task1.description).to eq 'take out the trash'
    end

    it "has a priority between 1 and 3" do
      expect(task1.priority).to be_within(2).of(3)
      expect(task2.priority).to be_within(2).of(1)
    end

    it "has a timestamp of when it is created" do
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-29 12:00PM"))
      fresh_task = TM::Task.new(my_project.id, 'do stuff NOW', 3)
      expect(fresh_task.timestamp).to eq (Time.parse("2014-04-29 12:00PM"))
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
