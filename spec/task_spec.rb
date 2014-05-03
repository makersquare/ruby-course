require 'spec_helper'

describe 'Task' do

  before(:each) do
    TM::Project.reset_class_vars
    TM::Task.reset_class_vars
    @my_project = TM::Project.new('my_project')
    @task1 = TM::Task.new(@my_project.id, 1, 'take out the trash')
    @task2 = TM::Task.new(@my_project.id, 1, 'clean up your room')
  end

  describe '.initialize' do
    it "has a unique id" do
      expect(@task1.id).to_not eq @task2.id
    end

    it "has a description string" do
      expect(@task1.description).to eq 'take out the trash'
    end

    it "has a priority between 1 and 3" do
      expect(@task1.priority).to be_within(2).of(3)
      expect(@task2.priority).to be_within(2).of(1)
    end

    it "has a timestamp of when it is created" do
      allow(Time).to receive(:now).and_return(Time.parse("2014-04-29 12:00PM"))
      fresh_task = TM::Task.new(@my_project.id, 'do stuff NOW', 3)
      expect(fresh_task.timestamp).to eq (Time.parse("2014-04-29 12:00PM"))
    end
  end

  describe '.mark_complete' do
    it "can be marked as complete, returning true if successful" do
      TM::Task.mark_complete(@task1.id)
      expect(@task1.complete).to eq true
    end
  end
end
