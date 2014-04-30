require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  before(:each) do
    @t1 = TM::Task.new("create a new task", 1)
    @t2 = TM::Task.new("eat lunch", 2)
    TM::Task.reset_class_variables
  end

  describe '.initialize' do
    it "sets a task ID number for new tasks" do
      expect(@t1.tid).to eq(1)
      expect(@t2.tid).to eq(2)
    end

    it "sets a description for new tasks" do
      expect(@t1.description).to eq("create a new task")
    end

    it "sets a priority number for new tasks" do
      expect(@t1.priority).to eq(1)
    end

    it "initializes with task set as incomplete" do
      expect(@t1.completed).to eq(false)
    end
  end

  describe '.set_complete' do
    before(:each) do
      @t1.set_complete
    end
    it "marks a task as completed" do
      expect(@t1.completed).to eq(true)
      expect(@t2.completed).to eq(false)
    end
  end
end
