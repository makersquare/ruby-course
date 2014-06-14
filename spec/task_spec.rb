require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  before(:each) do
    TM::Task.destroy_all_tasks(true)
  end

  describe "#initialize" do
    it "initializes with necessary attributes" do
      tsk = TM::Task.new('123', "desc", 5)
      expect(tsk.pid).to eql('123')
      expect(tsk.desc).to eql('desc')
      expect(tsk.priority).to eql(5)
    end
    it "validates and defaults priority properly" do
      tsk = TM::Task.new('123', "desc", 20)
      expect(tsk.priority).to eql(10)
      tsk = TM::Task.new('123', "desc", -25)
      expect(tsk.priority).to eql(0)
    end
    describe "#mark_complete" do
      it "can mark itself as completed" do
        tsk = TM::Task.new('123', "desc", 1)
        expect(tsk.complete).to eql(false)
        tsk.mark_complete
        expect(tsk.complete).to eql(true)
      end
    end
    describe ".get_task" do
      it "can retrieve a task from itself" do
        tsk1 = TM::Task.new('123', "something1", 1)
        tsk2 = TM::Task.new('123', "something2", 1)
        task_should_be2 = TM::Task.get_task(1)
        expect(task_should_be2).to eql(tsk2)
      end
    end
  end
end
